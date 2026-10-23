import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Maps service names to FluentUI icons. Keys must match the backend's service
/// names exactly (see `GET /api/service-providers/{id}` → `services[].name`).
/// Unknown names fall back to a generic service glyph in [getServiceIcon].
final Map<String, IconData> serviceNameToIcon = {
  'Boarding': FluentIcons.door_tag_24_regular,
  'Daycare': FluentIcons.home_person_24_regular,
  'Dental Care': FluentIcons.dentist_24_regular,
  'Deworming & Parasite Control': FluentIcons.bug_prohibited_20_regular,
  'Diagnostics & Lab Tests': FluentIcons.beaker_24_regular,
  'Dog Walking': FluentIcons.animal_dog_24_regular,
  'Emergency Care': FluentIcons.alert_urgent_24_regular,
  'Exotic Animal Care': FluentIcons.animal_paw_print_24_regular,
  'General Consultation': FluentIcons.stethoscope_24_regular,
  'Grooming': FluentIcons.cut_24_regular,
  'Home Visit': FluentIcons.home_24_regular,
  'Hospitalization': FluentIcons.briefcase_medical_24_regular,
  'Medication / Pharmacy': FluentIcons.pill_24_regular,
  'Microchipping': FluentIcons.shield_24_regular,
  'Nail Trimming': FluentIcons.cut_24_regular,
  'Pet Food & Supplies': FluentIcons.food_24_regular,
  'Pet Sitting': FluentIcons.people_24_regular,
  'Pet Transport': FluentIcons.vehicle_car_24_regular,
  'Spay / Neuter': FluentIcons.syringe_24_regular,
  'Surgery': FluentIcons.clipboard_pulse_24_regular,
  'Training': FluentIcons.person_24_regular,
  'Vaccination': FluentIcons.syringe_24_regular,
};

/// Get icon for a service by name, falling back to a generic service glyph
/// (not a checkmark) when the name isn't in [serviceNameToIcon].
IconData getServiceIcon(String serviceName) =>
    serviceNameToIcon[serviceName] ?? FluentIcons.briefcase_24_regular;
