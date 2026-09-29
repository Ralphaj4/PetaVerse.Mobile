import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

/// Maps service names to FluentUI icons.
final Map<String, IconData> serviceNameToIcon = {
  'General Consultation': FluentIcons.stethoscope_24_regular,
  'Vaccination': FluentIcons.shield_24_regular,
  'Microchipping': FluentIcons.circle_24_regular,
  'Deworming & Parasite Control': FluentIcons.drop_24_regular,
  'Grooming': FluentIcons.star_24_regular,
  'Training': FluentIcons.person_24_regular,
  'Boarding': FluentIcons.home_24_regular,
  'Dog Walking': FluentIcons.animal_dog_24_regular,
  'Pet Sitting': FluentIcons.people_24_regular,
  'Surgery': FluentIcons.heart_24_regular,
  'Dental Care': FluentIcons.heart_24_regular,
  'Eye Care': FluentIcons.eye_24_regular,
};

/// Maps species names to FluentUI icons.
final Map<String, IconData> speciesNameToIcon = {
  'Dog': FluentIcons.animal_dog_24_regular,
  'Cat': FluentIcons.animal_cat_24_regular,
  'Bird': FluentIcons.circle_24_regular,
  'Rabbit': FluentIcons.circle_24_regular,
  'Hamster': FluentIcons.circle_24_regular,
  'Fish': FluentIcons.drop_24_regular,
  'Reptile': FluentIcons.shield_24_regular,
  'Guinea Pig': FluentIcons.circle_24_regular,
};

/// Get icon for a service by name, with a fallback.
IconData getServiceIcon(String serviceName) =>
    serviceNameToIcon[serviceName] ?? FluentIcons.checkmark_circle_24_regular;

/// Get icon for a species by name, with a fallback.
IconData getSpeciesIcon(String speciesName) =>
    speciesNameToIcon[speciesName] ?? FluentIcons.animal_dog_24_regular;
