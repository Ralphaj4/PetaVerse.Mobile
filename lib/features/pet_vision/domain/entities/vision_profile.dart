/// Vision profile for a species — drives the color filter on the camera.
/// All matrix/parameter values are scientific approximations.
class VisionProfile {
  const VisionProfile({
    required this.speciesName,
    required this.displayName,
    required this.description,
    required this.funFact,
    required this.colorMatrix,
    required this.brightness,
    required this.contrast,
    required this.saturation,
  });

  /// The species key this profile belongs to (e.g. "dog", "cat").
  final String speciesName;

  /// Human-readable label shown in the UI.
  final String displayName;

  /// Short explanation of how this animal sees.
  final String description;

  /// One interesting fun fact shown on the camera overlay.
  final String funFact;

  /// 3×3 color-transform matrix (row-major) applied to RGB.
  final List<List<double>> colorMatrix;

  final double brightness;
  final double contrast;

  /// 0 = greyscale, 1 = full color.
  final double saturation;
}
