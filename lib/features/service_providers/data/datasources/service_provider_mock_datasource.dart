import 'package:latlong2/latlong.dart';

import '../../domain/entities/provider_category.dart';
import '../../domain/entities/service_provider.dart';

/// Static, deterministic mock providers used until the backend endpoint exists.
///
/// Positions are stored as small lat/lng offsets from the query center so the
/// pins always cluster around wherever the user actually is (or the fallback
/// city), instead of being pinned to one hard-coded city. Swapping this for a
/// real remote datasource is the only change needed to go live — the
/// repository and everything above it are already backend-shaped.
class ServiceProviderMockDataSource {
  const ServiceProviderMockDataSource();

  /// Returns the seed providers offset around [center]. Distance/sort is
  /// applied by the repository, not here.
  List<ServiceProvider> nearby(LatLng center) {
    LatLng at(double dLat, double dLng) =>
        LatLng(center.latitude + dLat, center.longitude + dLng);

    return [
      ServiceProvider(
        id: 'sp_1',
        name: 'Happy Paws Veterinary Clinic',
        category: ProviderCategory.veterinary,
        location: at(0.006, 0.004),
        address: 'Rue Gouraud, Gemmayzeh',
        rating: 4.8,
        reviewCount: 342,
        isOpen: true,
        phone: '+96170123456',
        badges: const {ProviderBadge.verified, ProviderBadge.open24_7},
        hoursLabel: 'Open 24 hours',
        photoUrl:
            'https://images.unsplash.com/photo-1596492784531-6e6eb5ea9993?w=400',
      ),
      ServiceProvider(
        id: 'sp_2',
        name: 'The Grooming Lounge',
        category: ProviderCategory.grooming,
        location: at(-0.003, 0.006),
        address: 'Mar Mikhael Main St',
        rating: 4.6,
        reviewCount: 128,
        isOpen: true,
        phone: '+96171234567',
        badges: const {ProviderBadge.verified, ProviderBadge.mobileService},
        hoursLabel: 'Closes 7 PM',
        photoUrl:
            'https://images.unsplash.com/photo-1583512603805-3cc6b41f3edb?w=400',
      ),
      ServiceProvider(
        id: 'sp_3',
        name: 'PetaWorld Superstore',
        category: ProviderCategory.petShop,
        location: at(0.004, -0.005),
        address: 'ABC Mall, Achrafieh',
        rating: 4.4,
        reviewCount: 512,
        isOpen: true,
        phone: '+96176345678',
        badges: const {ProviderBadge.verified},
        hoursLabel: 'Closes 9 PM',
        photoUrl:
            'https://images.unsplash.com/photo-1601758228041-f3b2795255f1?w=400',
      ),
      ServiceProvider(
        id: 'sp_4',
        name: 'Cozy Tails Boarding',
        category: ProviderCategory.boarding,
        location: at(-0.007, -0.003),
        address: 'Hamra, Rue de Rome',
        rating: 4.9,
        reviewCount: 89,
        isOpen: false,
        phone: '+96170987654',
        badges: const {ProviderBadge.verified},
        hoursLabel: 'Opens 8 AM',
        photoUrl:
            'https://images.unsplash.com/photo-1548767797-d8c844163c4c?w=400',
      ),
      ServiceProvider(
        id: 'sp_5',
        name: 'Good Dog Academy',
        category: ProviderCategory.training,
        location: at(0.009, 0.008),
        address: 'Sioufi, Achrafieh',
        rating: 4.7,
        reviewCount: 64,
        isOpen: true,
        phone: '+96181112233',
        hoursLabel: 'Closes 6 PM',
        photoUrl:
            'https://images.unsplash.com/photo-1591160690555-5debfba289f0?w=400',
      ),
      ServiceProvider(
        id: 'sp_6',
        name: '24/7 Animal Emergency Center',
        category: ProviderCategory.emergency,
        location: at(-0.002, -0.008),
        address: 'Furn el Chebbak Blvd',
        rating: 4.5,
        reviewCount: 201,
        isOpen: true,
        phone: '+96176000911',
        badges: const {
          ProviderBadge.verified,
          ProviderBadge.emergency,
          ProviderBadge.open24_7,
        },
        hoursLabel: 'Open 24 hours',
        photoUrl:
            'https://images.unsplash.com/photo-1628009368231-7bb7cfcb0def?w=400',
      ),
      ServiceProvider(
        id: 'sp_7',
        name: 'PawCare Pharmacy',
        category: ProviderCategory.pharmacy,
        location: at(0.001, 0.009),
        address: 'Sassine Square, Achrafieh',
        rating: 4.3,
        reviewCount: 47,
        isOpen: true,
        phone: '+96170445566',
        hoursLabel: 'Closes 8 PM',
      ),
      ServiceProvider(
        id: 'sp_8',
        name: 'Second Chance Shelter',
        category: ProviderCategory.shelter,
        location: at(-0.009, 0.002),
        address: 'Dekwaneh Industrial Zone',
        rating: 4.9,
        reviewCount: 156,
        isOpen: true,
        phone: '+96103778899',
        badges: const {ProviderBadge.verified},
        hoursLabel: 'Closes 5 PM',
        photoUrl:
            'https://images.unsplash.com/photo-1450778869180-41d0601e046e?w=400',
      ),
      ServiceProvider(
        id: 'sp_9',
        name: 'Whiskers & Wanders Pet Sitting',
        category: ProviderCategory.petSitting,
        location: at(0.007, -0.009),
        address: 'Badaro, Rue 88',
        rating: 4.8,
        reviewCount: 73,
        isOpen: true,
        phone: '+96171556677',
        badges: const {ProviderBadge.mobileService},
        hoursLabel: 'Closes 10 PM',
      ),
      ServiceProvider(
        id: 'sp_10',
        name: 'City Dog Walkers',
        category: ProviderCategory.walking,
        location: at(0.011, -0.001),
        address: 'Downtown, Weygand St',
        rating: 4.6,
        reviewCount: 38,
        isOpen: true,
        phone: '+96176889900',
        badges: const {ProviderBadge.mobileService},
        hoursLabel: 'Closes 7 PM',
      ),
      ServiceProvider(
        id: 'sp_11',
        name: 'Forever Home Adoptions',
        category: ProviderCategory.adoption,
        location: at(-0.005, 0.010),
        address: 'Jal el Dib Highway',
        rating: 4.7,
        reviewCount: 94,
        isOpen: false,
        phone: '+96104223344',
        badges: const {ProviderBadge.verified},
        hoursLabel: 'Opens 10 AM',
        photoUrl:
            'https://images.unsplash.com/photo-1444212477490-ca407925329e?w=400',
      ),
      ServiceProvider(
        id: 'sp_12',
        name: 'Central Vet Hospital',
        category: ProviderCategory.veterinary,
        location: at(0.013, 0.006),
        address: 'Jdeideh, Main Road',
        rating: 4.5,
        reviewCount: 267,
        isOpen: true,
        phone: '+96101667788',
        badges: const {ProviderBadge.verified},
        hoursLabel: 'Closes 8 PM',
        photoUrl:
            'https://images.unsplash.com/photo-1607923432780-7a9c30adcb72?w=400',
      ),
    ];
  }
}
