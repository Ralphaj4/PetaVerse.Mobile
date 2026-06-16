import 'package:latlong2/latlong.dart';

enum AlertType { lost, found }

class PetAlert {
  const PetAlert({
    required this.id,
    required this.type,
    required this.petName,
    required this.breed,
    required this.description,
    required this.location,
    required this.locationLabel,
    required this.hoursAgo,
    required this.latLng,
    this.imageUrl,
    this.ownerPhone,
  });

  final String id;
  final AlertType type;
  final String petName;
  final String breed;
  final String description;
  final String location;
  final String locationLabel;
  final int hoursAgo;
  final LatLng latLng;
  final String? imageUrl;
  final String? ownerPhone;
}
