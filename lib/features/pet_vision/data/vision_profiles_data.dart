import '../domain/entities/vision_profile.dart';

/// Hardcoded vision profiles keyed by lowercase species name.
/// Matches against [Pet.speciesName] (case-insensitive).
/// These are scientific approximations of each species' dichromat/trichromat
/// color perception, expressed as a 3×3 RGB transform matrix.
const Map<String, VisionProfile> visionProfiles = {
  'dog': VisionProfile(
    speciesName: 'dog',
    displayName: 'Canine Vision',
    description: 'Dogs are dichromats — they see blue and yellow, but not red.',
    funFact: 'Dogs can detect motion up to 5× better than humans.',
    // Simulates protanopia-like dichromacy: reds shift to yellow/brown.
    colorMatrix: [
      [0.56, 0.44, 0.00],
      [0.55, 0.45, 0.00],
      [0.00, 0.24, 0.76],
    ],
    brightness: 0.95,
    contrast: 1.05,
    saturation: 0.55,
  ),
  'cat': VisionProfile(
    speciesName: 'cat',
    displayName: 'Feline Vision',
    description: 'Cats are dichromats with excellent low-light vision and a blue-green tint.',
    funFact: 'Cats can see in light 6× dimmer than what humans need.',
    colorMatrix: [
      [0.40, 0.50, 0.10],
      [0.35, 0.55, 0.10],
      [0.00, 0.30, 0.70],
    ],
    brightness: 1.15,
    contrast: 0.95,
    saturation: 0.50,
  ),
  'bird': VisionProfile(
    speciesName: 'bird',
    displayName: 'Avian Vision',
    description: 'Birds are tetrachromats — they see UV light and have richer color than humans.',
    funFact: 'Birds can see the Earth\'s magnetic field as a visual overlay.',
    // Tetrachromacy simulation: shifted toward UV/violet, boosted saturation.
    colorMatrix: [
      [0.80, 0.10, 0.10],
      [0.10, 0.80, 0.10],
      [0.20, 0.10, 0.70],
    ],
    brightness: 1.05,
    contrast: 1.10,
    saturation: 1.40,
  ),
  'rabbit': VisionProfile(
    speciesName: 'rabbit',
    displayName: 'Rabbit Vision',
    description: 'Rabbits are dichromats with a nearly 360° field of view.',
    funFact: 'Rabbits have a blind spot directly in front of their nose.',
    colorMatrix: [
      [0.35, 0.55, 0.10],
      [0.25, 0.65, 0.10],
      [0.00, 0.20, 0.80],
    ],
    brightness: 0.90,
    contrast: 1.00,
    saturation: 0.45,
  ),
  'fish': VisionProfile(
    speciesName: 'fish',
    displayName: 'Aquatic Vision',
    description: 'Many fish see UV and polarized light, with a wide blue-shifted spectrum.',
    funFact: 'Some fish can see in four color channels, including near-ultraviolet.',
    colorMatrix: [
      [0.20, 0.30, 0.50],
      [0.15, 0.55, 0.30],
      [0.05, 0.15, 0.80],
    ],
    brightness: 0.85,
    contrast: 1.05,
    saturation: 0.90,
  ),
  'hamster': VisionProfile(
    speciesName: 'hamster',
    displayName: 'Hamster Vision',
    description: 'Hamsters have poor color vision and are nearsighted, but detect motion well.',
    funFact: 'Hamsters rely more on smell than sight to navigate.',
    colorMatrix: [
      [0.30, 0.60, 0.10],
      [0.30, 0.60, 0.10],
      [0.00, 0.30, 0.70],
    ],
    brightness: 0.80,
    contrast: 0.90,
    saturation: 0.25,
  ),
};

/// Falls back to a neutral "unknown" profile when the species isn't mapped.
const VisionProfile unknownVisionProfile = VisionProfile(
  speciesName: 'unknown',
  displayName: 'Unknown Vision',
  description: 'Vision profile not available for this species yet.',
  funFact: 'Every animal sees the world differently.',
  colorMatrix: [
    [1.0, 0.0, 0.0],
    [0.0, 1.0, 0.0],
    [0.0, 0.0, 1.0],
  ],
  brightness: 1.0,
  contrast: 1.0,
  saturation: 1.0,
);

VisionProfile profileForSpecies(String? speciesName) {
  if (speciesName == null) return unknownVisionProfile;
  return visionProfiles[speciesName.toLowerCase()] ?? unknownVisionProfile;
}
