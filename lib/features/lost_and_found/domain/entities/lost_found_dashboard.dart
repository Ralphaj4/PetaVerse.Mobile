import 'lost_found_report.dart';

/// A lightweight map pin from the dashboard — only what's needed to drop a
/// marker (full details live in [LostFoundReport]). All in-radius active
/// reports appear as pins, regardless of the recent-alerts filter.
///
/// Domain layer — no Flutter or JSON imports.
class LostFoundMapPin {
  const LostFoundMapPin({
    required this.id,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

  final int id;
  final ReportType type;
  final double latitude;
  final double longitude;
}

/// The signed-in user's volunteer status plus the global active-volunteer
/// count, shown in the dashboard's volunteer CTA.
class VolunteerInfo {
  const VolunteerInfo({
    required this.isVolunteer,
    required this.activeVolunteerCount,
  });

  final bool isVolunteer;
  final int activeVolunteerCount;
}

/// Everything the Lost & Found dashboard needs in one fetch: the active-alert
/// count and radius, all in-radius pins, the filtered recent alerts, and the
/// viewer's volunteer status.
class LostFoundDashboard {
  const LostFoundDashboard({
    required this.activeAlertCount,
    required this.radiusKm,
    required this.mapPins,
    required this.recentAlerts,
    required this.volunteerInfo,
  });

  final int activeAlertCount;
  final double radiusKm;
  final List<LostFoundMapPin> mapPins;
  final List<LostFoundReport> recentAlerts;
  final VolunteerInfo volunteerInfo;

  /// Returns a copy with [volunteerInfo] replaced — used to patch the
  /// volunteer status in place after join/leave without refetching.
  LostFoundDashboard copyWith({VolunteerInfo? volunteerInfo}) =>
      LostFoundDashboard(
        activeAlertCount: activeAlertCount,
        radiusKm: radiusKm,
        mapPins: mapPins,
        recentAlerts: recentAlerts,
        volunteerInfo: volunteerInfo ?? this.volunteerInfo,
      );
}
