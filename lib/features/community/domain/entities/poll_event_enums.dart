/// Enums for community polls & events. Pure Dart — wire values are ints, mapped
/// through `fromWire` helpers so declaration order never has to match the API.
library;

/// A pet's RSVP state for an event (`AttendeeStatus`).
enum AttendeeStatus {
  attending,
  interested,
  declined,
}

/// Maps the wire int (0 = Attending, 1 = Interested, 2 = Declined) to the enum.
/// Unknown values fall back to [AttendeeStatus.interested].
AttendeeStatus attendeeStatusFromWire(int value) => switch (value) {
      0 => AttendeeStatus.attending,
      1 => AttendeeStatus.interested,
      2 => AttendeeStatus.declined,
      _ => AttendeeStatus.interested,
    };

/// The wire int for an [AttendeeStatus].
extension AttendeeStatusWire on AttendeeStatus {
  int get wire => switch (this) {
        AttendeeStatus.attending => 0,
        AttendeeStatus.interested => 1,
        AttendeeStatus.declined => 2,
      };
}
