import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:camera/camera.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gal/gal.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
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

  XFile? _capturedImage;
  bool _showOriginal = false;

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
      controller.dispose();
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
      final back = _cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => _cameras.first,
      );
      final controller = CameraController(
        back,
        ResolutionPreset.high,
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

  Future<void> _saveToGallery() async {
    final file = _capturedImage;
    if (file == null) return;
    try {
      // Read the image file
      final imageBytes = await File(file.path).readAsBytes();
      final image = img.decodeImage(imageBytes);
      if (image == null) throw Exception('Failed to decode image');

      // Get the current pet for filter
      final petsState = ref.read(petsProvider);
      final petRef = petsState.currentPet;
      if (petRef == null) throw Exception('No pet selected');

      // Get the pet detail to access speciesName
      final petDetail = ref.read(petDetailProvider(petRef.id)).asData?.value;
      if (petDetail == null || petDetail.speciesName == null) {
        throw Exception('Species not found');
      }

      // Get the vision profile synchronously using the provider's cached value
      final profileState = ref.read(visionProfileByNameProvider(petDetail.speciesName!));
      final profile = profileState.asData?.value;
      if (profile == null) throw Exception('Vision profile not available');

      // Apply color filter to the image
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

      // Encode and save to gallery
      final filteredBytes = img.encodeJpg(image);
      await Gal.putImageBytes(filteredBytes);
      if (mounted) context.showSuccessSnackBar(context.l10n.photoSavedToGallery);
    } catch (_) {
      if (mounted) context.showErrorSnackBar(context.l10n.couldNotSavePhoto);
    }
  }

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
              allPets: petsState.refs,
              onBack: _navigateBack,
              onCapture: _capture,
              onGalleryPressed: _openGallery,
              onSave: _saveToGallery,
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
    required this.allPets,
    required this.onBack,
    required this.onCapture,
    required this.onGalleryPressed,
    required this.onSave,
    required this.onRetake,
    required this.onToggleOriginal,
    required this.onPetSelected,
  });

  final PetRef petRef;
  final CameraController? cameraController;
  final String? cameraError;
  final XFile? capturedImage;
  final bool showOriginal;
  final List<PetRef> allPets;
  final VoidCallback onBack;
  final VoidCallback onCapture;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
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
        log('🐾 Pet loaded: ${pet.name}, species: ${pet.speciesName}');
        final profileAsync = ref.watch(visionProfileByNameProvider(pet.speciesName ?? ''));
        log('👁️ Watching visionProfileByNameProvider(${pet.speciesName ?? "null"})');
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
              allPets: allPets,
              onBack: onBack,
              onCapture: onCapture,
              onGalleryPressed: onGalleryPressed,
              onSave: onSave,
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
              allPets: allPets,
              onBack: onBack,
              onCapture: onCapture,
              onGalleryPressed: onGalleryPressed,
              onSave: onSave,
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
    required this.allPets,
    required this.onBack,
    required this.onCapture,
    required this.onGalleryPressed,
    required this.onSave,
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
  final List<PetRef> allPets;
  final VoidCallback onBack;
  final VoidCallback onCapture;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
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
            onCapture: onCapture,
            onGalleryPressed: onGalleryPressed,
            onSave: onSave,
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

    return ColorFiltered(
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

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                profile.displayName,
                style: AppTextStyles.titleSmall
                    .copyWith(color: Colors.white),
              ),
              Text(
                perspectiveLabel,
                style: AppTextStyles.bodySmall
                    .copyWith(
                      color: showOriginal ? Colors.white70 : AppColors.primary,
                      fontWeight: showOriginal ? FontWeight.w600 : FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
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
    required this.onCapture,
    required this.onGalleryPressed,
    required this.onSave,
    required this.onRetake,
  });

  final bool hasCaptured;
  final VoidCallback onCapture;
  final VoidCallback onGalleryPressed;
  final VoidCallback onSave;
  final VoidCallback onRetake;

  @override
  Widget build(BuildContext context) {
    if (hasCaptured) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _GlassButton(
            onTap: onRetake,
            child: const Icon(FluentIcons.arrow_counterclockwise_24_regular,
                color: Colors.white, size: 22),
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
        const SizedBox(width: 48),
      ],
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
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: Colors.white12),
            ),
            alignment: Alignment.center,
            child: child,
          ),
        ),
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
