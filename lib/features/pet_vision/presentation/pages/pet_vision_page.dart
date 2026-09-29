import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../features/community/presentation/models/pawhub_models.dart';
import '../../../../features/community/presentation/providers/community_providers.dart';
import '../../../../features/community/presentation/widgets/post_composer_page.dart';
import '../../../../features/pets/domain/entities/pet.dart';
import '../../../../features/pets/domain/entities/pet_ref.dart';
import '../../../../features/pets/presentation/providers/pet_detail_provider.dart';
import '../../../../features/pets/presentation/providers/pets_provider.dart';
import '../providers/vision_profile_provider.dart';
import '../../domain/entities/vision_profile.dart';

class PetVisionPage extends ConsumerStatefulWidget {
  const PetVisionPage({super.key});

  @override
  ConsumerState<PetVisionPage> createState() => _PetVisionPageState();
}

class _PetVisionPageState extends ConsumerState<PetVisionPage>
    with WidgetsBindingObserver {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _cameraReady = false;
  String? _cameraError;
  CameraLensDirection _lensDirection = CameraLensDirection.back;

  XFile? _capturedImage;
  bool _showOriginal = false;
  bool _preparingForPost = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Wait for the route transition to finish before touching the camera,
    // so the animation isn't competing with camera initialization.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ModalRoute.of(context)?.animation?.addStatusListener(_onRouteStatus);
    });
  }

  void _onRouteStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      ModalRoute.of(context)?.animation?.removeStatusListener(_onRouteStatus);
      _initCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // Controller is disposed in _navigateBack before pop, so it may already
    // be null here — guard accordingly.
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _navigateBack() async {
    final controller = _controller;
    if (controller != null && controller.value.isInitialized) {
      await controller.dispose();
      _controller = null;
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      // Tear the preview down cleanly so build() stops handing a
      // disposed controller to CameraPreview while backgrounded.
      controller.dispose();
      if (mounted) {
        setState(() {
          _controller = null;
          _cameraReady = false;
        });
      }
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
    }
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() => _cameraError = 'No cameras found');
        return;
      }
      final camera = _cameras.firstWhere(
        (c) => c.lensDirection == _lensDirection,
        orElse: () => _cameras.first,
      );
      // Medium is plenty for a full-screen preview and keeps the per-frame
      // ColorFilter cheap; the capture path re-decodes the still separately so
      // saved photos aren't limited by this.
      final controller = CameraController(
        camera,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller.initialize();
      if (!mounted) return;
      setState(() {
        _controller = controller;
        _cameraReady = true;
        _cameraError = null;
      });
    } catch (e) {
      if (mounted) setState(() => _cameraError = e.toString());
    }
  }

  Future<void> _capture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized) return;
    try {
      final file = await controller.takePicture();
      if (mounted) setState(() => _capturedImage = file);
    } catch (_) {}
  }

  Future<void> _openGallery() async {
    final file = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 90,
    );
    if (file != null && mounted) setState(() => _capturedImage = file);
  }

  void _retake() => setState(() => _capturedImage = null);

  /// Toggles between the back and front camera. Tears the current preview down
  /// and re-initializes on the chosen lens (the platform can't switch a live
  /// controller's camera in place). No-op while an image is captured or when
  /// only one lens is available.
  Future<void> _flipCamera() async {
    if (_capturedImage != null || _cameras.length < 2) return;
    final controller = _controller;
    _lensDirection = _lensDirection == CameraLensDirection.back
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    if (controller != null && controller.value.isInitialized) {
      await controller.dispose();
    }
    if (!mounted) return;
    setState(() {
      _controller = null;
      _cameraReady = false;
    });
    await _initCamera();
  }

  /// Decodes the captured still and bakes the active pet-vision filter into the
  /// pixels, returning encoded JPEG bytes. When [showOriginal] is on (or no
  /// profile is available) the original bytes are returned unchanged so what's
  /// exported matches what's on screen. Returns null on decode failure.
  Future<List<int>?> _renderFilteredBytes(XFile file) async {
    final imageBytes = await File(file.path).readAsBytes();

    // "Show original" is on → export exactly what the user sees (no filter).
    if (_showOriginal) return imageBytes;

    final image = img.decodeImage(imageBytes);
    if (image == null) return null;

    // Resolve the active pet's vision profile from the provider caches. If any
    // link is missing, fall back to the untouched capture rather than failing.
    final petRef = ref.read(petsProvider).currentPet;
    if (petRef == null) return imageBytes;
    final petDetail = ref.read(petDetailProvider(petRef.id)).asData?.value;
    final speciesName = petDetail?.speciesName;
    if (speciesName == null) return imageBytes;
    final profile =
        ref.read(visionProfileByNameProvider(speciesName)).asData?.value;
    if (profile == null) return imageBytes;

    final colorMatrix = profile.colorMatrix;
    final saturation = profile.saturation;
    final brightness = profile.brightness;

    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        final pixel = image.getPixelSafe(x, y);
        final r = pixel.r.toDouble() / 255.0;
        final g = pixel.g.toDouble() / 255.0;
        final b = pixel.b.toDouble() / 255.0;

        // Apply 3x3 color matrix
        final nr = (colorMatrix[0][0] * r + colorMatrix[0][1] * g + colorMatrix[0][2] * b) * saturation + (1 - saturation) * (0.2126 * r + 0.7152 * g + 0.0722 * b);
        final ng = (colorMatrix[1][0] * r + colorMatrix[1][1] * g + colorMatrix[1][2] * b) * saturation + (1 - saturation) * (0.2126 * r + 0.7152 * g + 0.0722 * b);
        final nb = (colorMatrix[2][0] * r + colorMatrix[2][1] * g + colorMatrix[2][2] * b) * saturation + (1 - saturation) * (0.2126 * r + 0.7152 * g + 0.0722 * b);

        // Apply brightness
        final finalR = (nr * brightness * 255).clamp(0, 255).toInt();
        final finalG = (ng * brightness * 255).clamp(0, 255).toInt();
        final finalB = (nb * brightness * 255).clamp(0, 255).toInt();

        image.setPixelRgba(x, y, finalR, finalG, finalB, pixel.a.toInt());
      }
    }

    return img.encodeJpg(image);
  }

  Future<void> _saveToGallery() async {
    final file = _capturedImage;
    if (file == null) return;
    try {
      final bytes = await _renderFilteredBytes(file);
      if (bytes == null) throw Exception('Failed to decode image');
      await Gal.putImageBytes(Uint8List.fromList(bytes));
      if (mounted) context.showSuccessSnackBar(context.l10n.photoSavedToGallery);
    } catch (_) {
      if (mounted) context.showErrorSnackBar(context.l10n.couldNotSavePhoto);
    }
  }

  /// Bakes the current filter into the captured still, writes it to a temp file,
  /// and opens the post composer pre-seeded with that image. The camera preview
  /// is torn down first (the composer runs on the root navigator over this
  /// page) so it isn't left running behind the composer.
  Future<void> _useInPost() async {
    final file = _capturedImage;
    if (file == null || _preparingForPost) return;

    final myPets = ref
        .read(switchablePetsProvider)
        .map(_toPawPet)
        .toList();
    if (myPets.isEmpty) return;
    final actingRef = ref.read(actingPetProvider);
    final actingPaw =
        actingRef != null ? _toPawPet(actingRef) : myPets.first;

    setState(() => _preparingForPost = true);
    try {
      final bytes = await _renderFilteredBytes(file);
      if (bytes == null) throw Exception('Failed to decode image');

      final dir = await getTemporaryDirectory();
      final path =
          '${dir.path}/pet_vision_${file.name.hashCode}_${bytes.length}.jpg';
      await File(path).writeAsBytes(bytes, flush: true);

      if (!mounted) return;
      // Release the camera before the composer covers this page so the preview
      // isn't left running behind it. It re-initializes when we return.
      final controller = _controller;
      if (controller != null && controller.value.isInitialized) {
        await controller.dispose();
      }
      if (!mounted) return;
      setState(() {
        _controller = null;
        _cameraReady = false;
      });

      await Navigator.of(context, rootNavigator: true).push<void>(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => PostComposerPage(
            myPets: myPets,
            actingAs: actingPaw,
            taggablePets: const [],
            initialImagePaths: [path],
          ),
        ),
      );
      // Back from the composer: bring the preview back and clear the still so
      // the user lands on a live camera again.
      if (mounted) {
        setState(() => _capturedImage = null);
        await _initCamera();
      }
    } catch (_) {
      if (mounted) context.showErrorSnackBar(context.l10n.couldNotPreparePhoto);
    } finally {
      if (mounted) setState(() => _preparingForPost = false);
    }
  }

  PawPet _toPawPet(PetRef r) => PawPet(
        id: r.id.toString(),
        backendId: r.id,
        name: r.name,
        breed: '',
        species: '',
        avatarUrl: r.imagePath,
        ownerName: 'You',
        isMine: true,
      );

  @override
  Widget build(BuildContext context) {
    final petsState = ref.watch(petsProvider);
    final currentPetRef = petsState.currentPet;

    return Scaffold(
      backgroundColor: Colors.black,
      body: currentPetRef == null
          ? _NoPetView(onBack: _navigateBack)
          : _PetVisionBody(
              petRef: currentPetRef,
              cameraController: _cameraReady ? _controller : null,
              cameraError: _cameraError,
              capturedImage: _capturedImage,
              showOriginal: _showOriginal,
              canFlip: _cameras.length > 1,
              preparingForPost: _preparingForPost,
              allPets: petsState.refs,
              onBack: _navigateBack,
              onCapture: _capture,
              onFlip: _flipCamera,
              onGalleryPressed: _openGallery,
              onSave: _saveToGallery,
              onUseInPost: _useInPost,
              onRetake: _retake,
              onToggleOriginal: (v) => setState(() => _showOriginal = v),
              onPetSelected: (id) =>
                  ref.read(petsProvider.notifier).selectPet(id),
            ),
    );
  }
}

// ── Body (resolves pet → profile) ─────────────────────────────────────────────

class _PetVisionBody extends ConsumerWidget {
  const _PetVisionBody({
    required this.petRef,
    required this.cameraController,
    required this.cameraError,
    required this.capturedImage,
    required this.showOriginal,
    required this.canFlip,
    required this.preparingForPost,
    required this.allPets,
    required this.onBack,
    required this.onCapture,
    required this.onFlip,
    required this.onGalleryPressed,
    required this.onSave,
    required this.onUseInPost,
    required this.onRetake,
    required this.onToggleOriginal,
    required this.onPetSelected,
  });

  final PetRef petRef;
  final CameraController? cameraController;
  final String? cameraError;
  final XFile? capturedImage;
  final bool showOriginal;
  final bool canFlip;
  final bool preparingForPost;
  final List<PetRef> allPets;
  final VoidCallback onBack;
  final VoidCallback onCapture;
  final VoidCallback onFlip;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
  final VoidCallback onUseInPost;
  final VoidCallback onRetake;
  final ValueChanged<bool> onToggleOriginal;
  final ValueChanged<int> onPetSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petAsync = ref.watch(petDetailProvider(petRef.id));

    return petAsync.when(
      loading: () => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
      error: (_, _) => const Center(
        child: Icon(FluentIcons.warning_24_regular,
            color: Colors.white54, size: 48),
      ),
      data: (pet) {
        final profileAsync =
            ref.watch(visionProfileByNameProvider(pet.speciesName ?? ''));
        return profileAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
          error: (_, _) {
            // Fallback if profile fetch fails
            final fallback = VisionProfile(
              speciesName: pet.speciesName ?? 'unknown',
              displayName: pet.speciesName ?? 'Unknown',
              description: 'Vision profile unavailable.',
              funFact: 'Every animal sees the world differently.',
              colorMatrix: const [
                [1.0, 0.0, 0.0],
                [0.0, 1.0, 0.0],
                [0.0, 0.0, 1.0],
              ],
              brightness: 1.0,
              contrast: 1.0,
              saturation: 1.0,
            );
            return _VisionLayout(
              pet: pet,
              profile: fallback,
              cameraController: cameraController,
              cameraError: cameraError,
              capturedImage: capturedImage,
              showOriginal: showOriginal,
              canFlip: canFlip,
              preparingForPost: preparingForPost,
              allPets: allPets,
              onBack: onBack,
              onCapture: onCapture,
              onFlip: onFlip,
              onGalleryPressed: onGalleryPressed,
              onSave: onSave,
              onUseInPost: onUseInPost,
              onRetake: onRetake,
              onToggleOriginal: onToggleOriginal,
              onPetSelected: onPetSelected,
            );
          },
          data: (profile) {
            if (profile == null) {
              // Profile not found for species
              final fallback = VisionProfile(
                speciesName: pet.speciesName ?? 'unknown',
                displayName: pet.speciesName ?? 'Unknown',
                description: 'Vision profile not available for this species.',
                funFact: 'Profile coming soon!',
                colorMatrix: const [
                  [1.0, 0.0, 0.0],
                  [0.0, 1.0, 0.0],
                  [0.0, 0.0, 1.0],
                ],
                brightness: 1.0,
                contrast: 1.0,
                saturation: 1.0,
              );
              profile = fallback;
            }
            return _VisionLayout(
              pet: pet,
              profile: profile,
              cameraController: cameraController,
              cameraError: cameraError,
              capturedImage: capturedImage,
              showOriginal: showOriginal,
              canFlip: canFlip,
              preparingForPost: preparingForPost,
              allPets: allPets,
              onBack: onBack,
              onCapture: onCapture,
              onFlip: onFlip,
              onGalleryPressed: onGalleryPressed,
              onSave: onSave,
              onUseInPost: onUseInPost,
              onRetake: onRetake,
              onToggleOriginal: onToggleOriginal,
              onPetSelected: onPetSelected,
            );
          },
        );
      },
    );
  }
}

// ── Full layout ───────────────────────────────────────────────────────────────

class _VisionLayout extends StatelessWidget {
  const _VisionLayout({
    required this.pet,
    required this.profile,
    required this.cameraController,
    required this.cameraError,
    required this.capturedImage,
    required this.showOriginal,
    required this.canFlip,
    required this.preparingForPost,
    required this.allPets,
    required this.onBack,
    required this.onCapture,
    required this.onFlip,
    required this.onGalleryPressed,
    required this.onSave,
    required this.onUseInPost,
    required this.onRetake,
    required this.onToggleOriginal,
    required this.onPetSelected,
  });

  final Pet pet;
  final VisionProfile profile;
  final CameraController? cameraController;
  final String? cameraError;
  final XFile? capturedImage;
  final bool showOriginal;
  final bool canFlip;
  final bool preparingForPost;
  final List<PetRef> allPets;
  final VoidCallback onBack;
  final VoidCallback onCapture;
  final VoidCallback onFlip;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
  final VoidCallback onUseInPost;
  final VoidCallback onRetake;
  final ValueChanged<bool> onToggleOriginal;
  final ValueChanged<int> onPetSelected;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    final colorFilter = _buildColorFilter(profile, showOriginal);

    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Viewport ──
        capturedImage != null
            ? _ImageViewport(
                file: capturedImage!,
                colorFilter: colorFilter,
              )
            : _LiveViewport(
                controller: cameraController,
                error: cameraError,
                colorFilter: colorFilter,
              ),

        // ── Top left back button ──
        Positioned(
          top: topPad + AppSpacing.sm,
          left: AppSpacing.lg,
          child: _GlassButton(
            onTap: onBack,
            child: const Icon(FluentIcons.chevron_left_24_regular,
                color: Colors.white, size: 20),
          ),
        ),

        // ── Top center info bar ──
        Positioned(
          top: topPad + AppSpacing.sm,
          left: AppSpacing.lg + 48 + AppSpacing.md,
          right: AppSpacing.lg + 48 + AppSpacing.md,
          child: _InfoBar(
            pet: pet,
            profile: profile,
            hasCaptured: capturedImage != null,
            showOriginal: showOriginal,
            onToggleOriginal: onToggleOriginal,
          ),
        ),

        // ── Top right buttons (eye, question, lightbulb) ──
        Positioned(
          top: topPad + AppSpacing.sm,
          right: AppSpacing.lg,
          child: _RightControlsColumn(
            profile: profile,
            showOriginal: showOriginal,
            onToggleOriginal: onToggleOriginal,
          ),
        ),

        // ── Pet selector strip ──
        if (allPets.length > 1)
          Positioned(
            bottom: bottomPad + 110,
            left: 0,
            right: 0,
            child: _PetSelectorStrip(
              pets: allPets,
              activePetId: pet.id,
              onPetSelected: onPetSelected,
            ),
          ),

        // ── Bottom controls ──
        Positioned(
          bottom: bottomPad + AppSpacing.lg,
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          child: _BottomControls(
            hasCaptured: capturedImage != null,
            canFlip: canFlip,
            preparingForPost: preparingForPost,
            onCapture: onCapture,
            onFlip: onFlip,
            onGalleryPressed: onGalleryPressed,
            onSave: onSave,
            onUseInPost: onUseInPost,
            onRetake: onRetake,
          ),
        ),
      ],
    );
  }
}

// ── Color filter builder (shared by live + captured viewports) ────────────────

ColorFilter _buildColorFilter(VisionProfile profile, bool showOriginal) {
  if (showOriginal) {
    return const ColorFilter.matrix([
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 1, 0,
    ]);
  }

  final m = profile.colorMatrix;
  final s = profile.saturation;
  final bias = (profile.brightness - 1.0) * 255.0;

  const lum = [0.2126, 0.7152, 0.0722];
  List<double> mix(List<double> row) => [
        row[0] * s + lum[0] * (1 - s),
        row[1] * s + lum[1] * (1 - s),
        row[2] * s + lum[2] * (1 - s),
      ];

  final r = mix(m[0]);
  final g = mix(m[1]);
  final b = mix(m[2]);

  return ColorFilter.matrix([
    r[0], r[1], r[2], 0, bias,
    g[0], g[1], g[2], 0, bias,
    b[0], b[1], b[2], 0, bias,
    0,    0,    0,    1, 0,
  ]);
}

// ── Live camera viewport ──────────────────────────────────────────────────────

class _LiveViewport extends StatelessWidget {
  const _LiveViewport({
    required this.controller,
    required this.error,
    required this.colorFilter,
  });

  final CameraController? controller;
  final String? error;
  final ColorFilter colorFilter;

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(FluentIcons.camera_off_24_regular,
                color: Colors.white38, size: 56),
            const SizedBox(height: AppSpacing.md),
            Text('Camera unavailable',
                style:
                    AppTextStyles.bodyMedium.copyWith(color: Colors.white38)),
          ],
        ),
      );
    }

    if (controller == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    // Isolate the live preview + its per-frame ColorFilter in its own layer so
    // overlay rebuilds (pet-selector animation, control toggles, dialogs) don't
    // re-composite the camera. The ColorFilter is the one unavoidable per-frame
    // cost of this feature; everything else is kept off its layer.
    return RepaintBoundary(
      child: ColorFiltered(
        colorFilter: colorFilter,
        child: SizedBox.expand(
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: controller!.value.previewSize?.height ?? 1,
              height: controller!.value.previewSize?.width ?? 1,
              child: CameraPreview(controller!),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Captured image viewport ───────────────────────────────────────────────────

class _ImageViewport extends StatelessWidget {
  const _ImageViewport({required this.file, required this.colorFilter});

  final XFile file;
  final ColorFilter colorFilter;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: colorFilter,
      child: Image.file(
        File(file.path),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

// ── Info bar (center, shows species and pet name) ────────────────────────────

class _InfoBar extends StatelessWidget {
  const _InfoBar({
    required this.pet,
    required this.profile,
    required this.hasCaptured,
    required this.showOriginal,
    required this.onToggleOriginal,
  });

  final Pet pet;
  final VisionProfile profile;
  final bool hasCaptured;
  final bool showOriginal;
  final ValueChanged<bool> onToggleOriginal;

  @override
  Widget build(BuildContext context) {
    final perspectiveLabel = showOriginal ? 'Your perspective' : "${pet.name}'s perspective";

    // Solid translucent surface (not a BackdropFilter): over a live camera a
    // blur forces a full-screen saveLayer every frame, which is a major source
    // of preview lag. The look is near-identical at 55% opacity.
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            profile.displayName,
            style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
          ),
          Text(
            perspectiveLabel,
            style: AppTextStyles.bodySmall.copyWith(
              color: showOriginal ? Colors.white70 : AppColors.primary,
              fontWeight: showOriginal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Right controls (vertical stack: eye, question, lightbulb) ────────────────

class _RightControlsColumn extends StatelessWidget {
  const _RightControlsColumn({
    required this.profile,
    required this.showOriginal,
    required this.onToggleOriginal,
  });

  final VisionProfile profile;
  final bool showOriginal;
  final ValueChanged<bool> onToggleOriginal;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _GlassButton(
          onTap: () => onToggleOriginal(!showOriginal),
          child: Icon(
            showOriginal ? FluentIcons.eye_24_regular : FluentIcons.eye_24_filled,
            color: showOriginal ? Colors.white : AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _GlassButton(
          onTap: () => _showDescriptionDialog(context, profile),
          child: const Icon(
            FluentIcons.question_circle_24_regular,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _GlassButton(
          onTap: () => _showFunFactDialog(context, profile),
          child: const Icon(
            FluentIcons.lightbulb_24_regular,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }
}

void _showDescriptionDialog(BuildContext context, VisionProfile profile) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    FluentIcons.question_circle_24_filled,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      profile.displayName,
                      style: AppTextStyles.titleSmall
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                profile.description,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    context.l10n.gotIt,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

void _showFunFactDialog(BuildContext context, VisionProfile profile) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.black.withValues(alpha: 0.9),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    FluentIcons.lightbulb_24_filled,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      context.l10n.didYouKnow,
                      style: AppTextStyles.titleSmall
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                profile.funFact,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text(
                    context.l10n.gotIt,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ── Pet selector strip ────────────────────────────────────────────────────────

class _PetSelectorStrip extends StatelessWidget {
  const _PetSelectorStrip({
    required this.pets,
    required this.activePetId,
    required this.onPetSelected,
  });

  final List<PetRef> pets;
  final int activePetId;
  final ValueChanged<int> onPetSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        itemCount: pets.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.sm),
        itemBuilder: (_, i) {
          final pet = pets[i];
          final isActive = pet.id == activePetId;
          return GestureDetector(
            onTap: () => onPetSelected(pet.id),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.9)
                    : Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: isActive ? AppColors.primary : Colors.white24,
                  width: isActive ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    FluentIcons.animal_cat_24_regular,
                    size: 16,
                    color: isActive ? Colors.white : Colors.white70,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    pet.name,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isActive ? Colors.white : Colors.white70,
                      fontWeight:
                          isActive ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Bottom controls ───────────────────────────────────────────────────────────

class _BottomControls extends StatelessWidget {
  const _BottomControls({
    required this.hasCaptured,
    required this.canFlip,
    required this.preparingForPost,
    required this.onCapture,
    required this.onFlip,
    required this.onGalleryPressed,
    required this.onSave,
    required this.onUseInPost,
    required this.onRetake,
  });

  final bool hasCaptured;
  final bool canFlip;
  final bool preparingForPost;
  final VoidCallback onCapture;
  final VoidCallback onFlip;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
  final VoidCallback onUseInPost;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    if (hasCaptured) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _GlassButton(
            onTap: onRetake,
            child: const Icon(FluentIcons.arrow_counterclockwise_24_regular,
                color: Colors.white, size: 22),
          ),
          // Primary action: carry this shot into a new post.
          _UseInPostButton(
            busy: preparingForPost,
            onTap: preparingForPost ? null : onUseInPost,
          ),
          _GlassButton(
            onTap: onSave,
            child: const Icon(FluentIcons.arrow_download_24_regular,
                color: Colors.white, size: 22),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _GlassButton(
          onTap: onGalleryPressed,
          child: const Icon(FluentIcons.image_24_regular,
              color: Colors.white, size: 22),
        ),
        GestureDetector(
          onTap: onCapture,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(FluentIcons.camera_24_filled,
                color: Colors.white, size: 28),
          ),
        ),
        // Flip camera — kept in the layout as a fixed-width slot so the shutter
        // stays centered whether or not a second lens exists.
        canFlip
            ? Semantics(
                button: true,
                label: context.l10n.flipCamera,
                child: _GlassButton(
                  onTap: onFlip,
                  child: const Icon(FluentIcons.camera_switch_24_regular,
                      color: Colors.white, size: 22),
                ),
              )
            : const SizedBox(width: 48),
      ],
    );
  }
}

/// The orange "Use in post" pill shown under a captured still. Shows a spinner
/// while the filtered image is being baked out to a temp file.
class _UseInPostButton extends StatelessWidget {
  const _UseInPostButton({required this.busy, required this.onTap});

  final bool busy;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.useInPost,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: onTap == null ? 0.6 : 1),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.4),
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              busy
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(FluentIcons.send_24_filled,
                      color: Colors.white, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text(
                context.l10n.useInPost,
                style: AppTextStyles.titleSmall.copyWith(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Glass button ──────────────────────────────────────────────────────────────

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Solid translucent (no BackdropFilter): several of these sit over the live
    // camera at once, and each blur is a per-frame full-screen saveLayer.
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: Colors.white12),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

// ── No pet fallback ───────────────────────────────────────────────────────────

class _NoPetView extends StatelessWidget {
  const _NoPetView({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    return Padding(
      padding: EdgeInsets.only(top: topPad + AppSpacing.sm),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: _GlassButton(
                onTap: onBack,
                child: const Icon(FluentIcons.chevron_left_24_regular,
                    color: Colors.white, size: 20),
              ),
            ),
          ),
          const Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(FluentIcons.animal_cat_24_regular,
                      color: Colors.white24, size: 64),
                  SizedBox(height: AppSpacing.lg),
                  Text(
                    'No pet selected',
                    style: TextStyle(color: Colors.white54, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
