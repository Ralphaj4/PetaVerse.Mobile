import 'package:latlong2/latlong.dart';

import '../../domain/entities/lost_found_report.dart';

enum AlertType { lost, found }

/// Hero tag shared between a [PetAlertCard]'s image and the detail page's
/// image, so the photo animates between the list and the details screen.
String lostFoundHeroTag(int reportId) => 'lost-found-photo-$reportId';

class PetAlert {
  const PetAlert({
    required this.id,
    required this.reportId,
    required this.type,
    required this.petName,
    required this.breed,
    required this.description,
    required this.location,
    required this.locationLabel,
    required this.hoursAgo,
    required this.latLng,
    this.isOwner = false,
    this.reward,
    this.imageUrl,
    this.ownerPhone,
  });

  final String id;

  /// The report's numeric id, used for owner actions (e.g. delete).
  final int reportId;
  final AlertType type;
  final String petName;
  final String breed;
  final String description;
  final String location;
  final String locationLabel;
  final int hoursAgo;
  final LatLng latLng;

  /// True when the current user owns this report (can delete it).
  final bool isOwner;

  /// Reward offered for a Lost pet, or null when none.
  final int? reward;
  final String? imageUrl;
  final String? ownerPhone;

  /// Builds the UI model from a domain [LostFoundReport]. [now] is injected so
  /// `hoursAgo` is derived deterministically (and testably) from `createdAt`.
  factory PetAlert.fromReport(LostFoundReport r, {required DateTime now}) {
    final hours = now.difference(r.createdAt).inHours;
    return PetAlert(
      id: r.id.toString(),
      reportId: r.id,
      type: r.type == ReportType.found ? AlertType.found : AlertType.lost,
      petName: r.petName,
      breed: r.breedOrSpecies,
      description: r.description,
      location: r.lastSeenAddress,
      locationLabel: r.lastSeenAddress,
      hoursAgo: hours < 0 ? 0 : hours,
      latLng: LatLng(r.latitude, r.longitude),
      isOwner: r.isOwner,
      reward: r.reward,
      imageUrl: r.imageUrl,
      ownerPhone: r.reporterPhone,
    );
  }
}
