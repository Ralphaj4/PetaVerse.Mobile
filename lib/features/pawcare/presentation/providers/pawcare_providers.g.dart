// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pawcare_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(healthReminderCache)
final healthReminderCacheProvider = HealthReminderCacheProvider._();

final class HealthReminderCacheProvider
    extends
        $FunctionalProvider<
          HealthReminderLocalDataSource,
          HealthReminderLocalDataSource,
          HealthReminderLocalDataSource
        >
    with $Provider<HealthReminderLocalDataSource> {
  HealthReminderCacheProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'healthReminderCacheProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$healthReminderCacheHash();

  @$internal
  @override
  $ProviderElement<HealthReminderLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  HealthReminderLocalDataSource create(Ref ref) {
    return healthReminderCache(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HealthReminderLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HealthReminderLocalDataSource>(
        value,
      ),
    );
  }
}

String _$healthReminderCacheHash() =>
    r'bf5a8a9476d377f1dd0e550da75e2ae05e25e963';

@ProviderFor(pawCareRepository)
final pawCareRepositoryProvider = PawCareRepositoryProvider._();

final class PawCareRepositoryProvider
    extends
        $FunctionalProvider<
          PawCareRepository,
          PawCareRepository,
          PawCareRepository
        >
    with $Provider<PawCareRepository> {
  PawCareRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pawCareRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pawCareRepositoryHash();

  @$internal
  @override
  $ProviderElement<PawCareRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PawCareRepository create(Ref ref) {
    return pawCareRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PawCareRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PawCareRepository>(value),
    );
  }
}

String _$pawCareRepositoryHash() => r'a370d4ed27036ac16b560b0f6d29f570affe073a';

/// Loads the health snapshot for a pet — the three sections in parallel, with a
/// single loading / error surface for the dashboard. Family-keyed so each pet
/// caches independently.

@ProviderFor(petHealthSnapshot)
final petHealthSnapshotProvider = PetHealthSnapshotFamily._();

/// Loads the health snapshot for a pet — the three sections in parallel, with a
/// single loading / error surface for the dashboard. Family-keyed so each pet
/// caches independently.

final class PetHealthSnapshotProvider
    extends
        $FunctionalProvider<
          AsyncValue<PetHealthSnapshot>,
          PetHealthSnapshot,
          FutureOr<PetHealthSnapshot>
        >
    with
        $FutureModifier<PetHealthSnapshot>,
        $FutureProvider<PetHealthSnapshot> {
  /// Loads the health snapshot for a pet — the three sections in parallel, with a
  /// single loading / error surface for the dashboard. Family-keyed so each pet
  /// caches independently.
  PetHealthSnapshotProvider._({
    required PetHealthSnapshotFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petHealthSnapshotProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petHealthSnapshotHash();

  @override
  String toString() {
    return r'petHealthSnapshotProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PetHealthSnapshot> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PetHealthSnapshot> create(Ref ref) {
    final argument = this.argument as int;
    return petHealthSnapshot(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PetHealthSnapshotProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petHealthSnapshotHash() => r'68189819b88c0b759f6205dac2a30b951451ef7e';

/// Loads the health snapshot for a pet — the three sections in parallel, with a
/// single loading / error surface for the dashboard. Family-keyed so each pet
/// caches independently.

final class PetHealthSnapshotFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PetHealthSnapshot>, int> {
  PetHealthSnapshotFamily._()
    : super(
        retry: null,
        name: r'petHealthSnapshotProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Loads the health snapshot for a pet — the three sections in parallel, with a
  /// single loading / error surface for the dashboard. Family-keyed so each pet
  /// caches independently.

  PetHealthSnapshotProvider call(int petId) =>
      PetHealthSnapshotProvider._(argument: petId, from: this);

  @override
  String toString() => r'petHealthSnapshotProvider';
}

/// Full weight history for the history page. Separate from the snapshot so the
/// list page can refresh independently after an add.

@ProviderFor(weightHistory)
final weightHistoryProvider = WeightHistoryFamily._();

/// Full weight history for the history page. Separate from the snapshot so the
/// list page can refresh independently after an add.

final class WeightHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<WeightRecord>>,
          List<WeightRecord>,
          FutureOr<List<WeightRecord>>
        >
    with
        $FutureModifier<List<WeightRecord>>,
        $FutureProvider<List<WeightRecord>> {
  /// Full weight history for the history page. Separate from the snapshot so the
  /// list page can refresh independently after an add.
  WeightHistoryProvider._({
    required WeightHistoryFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'weightHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weightHistoryHash();

  @override
  String toString() {
    return r'weightHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<WeightRecord>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<WeightRecord>> create(Ref ref) {
    final argument = this.argument as int;
    return weightHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is WeightHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weightHistoryHash() => r'575ca970e40b1f457db0170f4b3e1bcfc8d4eaaa';

/// Full weight history for the history page. Separate from the snapshot so the
/// list page can refresh independently after an add.

final class WeightHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<WeightRecord>>, int> {
  WeightHistoryFamily._()
    : super(
        retry: null,
        name: r'weightHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Full weight history for the history page. Separate from the snapshot so the
  /// list page can refresh independently after an add.

  WeightHistoryProvider call(int petId) =>
      WeightHistoryProvider._(argument: petId, from: this);

  @override
  String toString() => r'weightHistoryProvider';
}

/// Active medications for the medications list page.

@ProviderFor(petMedications)
final petMedicationsProvider = PetMedicationsFamily._();

/// Active medications for the medications list page.

final class PetMedicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Medication>>,
          List<Medication>,
          FutureOr<List<Medication>>
        >
    with $FutureModifier<List<Medication>>, $FutureProvider<List<Medication>> {
  /// Active medications for the medications list page.
  PetMedicationsProvider._({
    required PetMedicationsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petMedicationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petMedicationsHash();

  @override
  String toString() {
    return r'petMedicationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Medication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Medication>> create(Ref ref) {
    final argument = this.argument as int;
    return petMedications(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PetMedicationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petMedicationsHash() => r'a148370133c2f92fb65a709cbe3207be38a7373d';

/// Active medications for the medications list page.

final class PetMedicationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Medication>>, int> {
  PetMedicationsFamily._()
    : super(
        retry: null,
        name: r'petMedicationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Active medications for the medications list page.

  PetMedicationsProvider call(int petId) =>
      PetMedicationsProvider._(argument: petId, from: this);

  @override
  String toString() => r'petMedicationsProvider';
}

/// Vaccination records for the vaccinations list page.

@ProviderFor(petVaccinations)
final petVaccinationsProvider = PetVaccinationsFamily._();

/// Vaccination records for the vaccinations list page.

final class PetVaccinationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Vaccination>>,
          List<Vaccination>,
          FutureOr<List<Vaccination>>
        >
    with
        $FutureModifier<List<Vaccination>>,
        $FutureProvider<List<Vaccination>> {
  /// Vaccination records for the vaccinations list page.
  PetVaccinationsProvider._({
    required PetVaccinationsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petVaccinationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petVaccinationsHash();

  @override
  String toString() {
    return r'petVaccinationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Vaccination>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Vaccination>> create(Ref ref) {
    final argument = this.argument as int;
    return petVaccinations(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PetVaccinationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petVaccinationsHash() => r'5ba4375bbaedf036c1f5ecb7facfbe03c30be3e3';

/// Vaccination records for the vaccinations list page.

final class PetVaccinationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Vaccination>>, int> {
  PetVaccinationsFamily._()
    : super(
        retry: null,
        name: r'petVaccinationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Vaccination records for the vaccinations list page.

  PetVaccinationsProvider call(int petId) =>
      PetVaccinationsProvider._(argument: petId, from: this);

  @override
  String toString() => r'petVaccinationsProvider';
}

/// Upcoming medications across all of the user's pets, within [daysAhead] days.

@ProviderFor(upcomingMedications)
final upcomingMedicationsProvider = UpcomingMedicationsFamily._();

/// Upcoming medications across all of the user's pets, within [daysAhead] days.

final class UpcomingMedicationsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UpcomingMedication>>,
          List<UpcomingMedication>,
          FutureOr<List<UpcomingMedication>>
        >
    with
        $FutureModifier<List<UpcomingMedication>>,
        $FutureProvider<List<UpcomingMedication>> {
  /// Upcoming medications across all of the user's pets, within [daysAhead] days.
  UpcomingMedicationsProvider._({
    required UpcomingMedicationsFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'upcomingMedicationsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$upcomingMedicationsHash();

  @override
  String toString() {
    return r'upcomingMedicationsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UpcomingMedication>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UpcomingMedication>> create(Ref ref) {
    final argument = this.argument as int;
    return upcomingMedications(ref, daysAhead: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingMedicationsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingMedicationsHash() =>
    r'df1ae1713f04d94e0caf534ebc28d1247c471375';

/// Upcoming medications across all of the user's pets, within [daysAhead] days.

final class UpcomingMedicationsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UpcomingMedication>>, int> {
  UpcomingMedicationsFamily._()
    : super(
        retry: null,
        name: r'upcomingMedicationsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Upcoming medications across all of the user's pets, within [daysAhead] days.

  UpcomingMedicationsProvider call({int daysAhead = 14}) =>
      UpcomingMedicationsProvider._(argument: daysAhead, from: this);

  @override
  String toString() => r'upcomingMedicationsProvider';
}

/// Cached upcoming health reminders (medication doses + vaccination boosters)
/// across all pets, for the home "Upcoming" section.
///
/// Reads purely from the local cache written on each medication / vaccination
/// fetch — no network. Pet names are joined from the pet gate (the per-pet
/// health endpoints don't carry them). Sorted soonest-first; overdue included.
/// A dedicated home endpoint will replace this source later.

@ProviderFor(upcomingHealthReminders)
final upcomingHealthRemindersProvider = UpcomingHealthRemindersProvider._();

/// Cached upcoming health reminders (medication doses + vaccination boosters)
/// across all pets, for the home "Upcoming" section.
///
/// Reads purely from the local cache written on each medication / vaccination
/// fetch — no network. Pet names are joined from the pet gate (the per-pet
/// health endpoints don't carry them). Sorted soonest-first; overdue included.
/// A dedicated home endpoint will replace this source later.

final class UpcomingHealthRemindersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HealthReminder>>,
          List<HealthReminder>,
          FutureOr<List<HealthReminder>>
        >
    with
        $FutureModifier<List<HealthReminder>>,
        $FutureProvider<List<HealthReminder>> {
  /// Cached upcoming health reminders (medication doses + vaccination boosters)
  /// across all pets, for the home "Upcoming" section.
  ///
  /// Reads purely from the local cache written on each medication / vaccination
  /// fetch — no network. Pet names are joined from the pet gate (the per-pet
  /// health endpoints don't carry them). Sorted soonest-first; overdue included.
  /// A dedicated home endpoint will replace this source later.
  UpcomingHealthRemindersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'upcomingHealthRemindersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$upcomingHealthRemindersHash();

  @$internal
  @override
  $FutureProviderElement<List<HealthReminder>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HealthReminder>> create(Ref ref) {
    return upcomingHealthReminders(ref);
  }
}

String _$upcomingHealthRemindersHash() =>
    r'f113997b5c7a33b7085790b9fdce4b87d9114f7f';

/// Known medication names for the add-medication picker.

@ProviderFor(medicationLookups)
final medicationLookupsProvider = MedicationLookupsProvider._();

/// Known medication names for the add-medication picker.

final class MedicationLookupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HealthLookup>>,
          List<HealthLookup>,
          FutureOr<List<HealthLookup>>
        >
    with
        $FutureModifier<List<HealthLookup>>,
        $FutureProvider<List<HealthLookup>> {
  /// Known medication names for the add-medication picker.
  MedicationLookupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'medicationLookupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$medicationLookupsHash();

  @$internal
  @override
  $FutureProviderElement<List<HealthLookup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HealthLookup>> create(Ref ref) {
    return medicationLookups(ref);
  }
}

String _$medicationLookupsHash() => r'7b06bd4d789202e5b36b3886100ac0ebda635e06';

/// Known vaccine names for the add-vaccination picker.

@ProviderFor(vaccineLookups)
final vaccineLookupsProvider = VaccineLookupsProvider._();

/// Known vaccine names for the add-vaccination picker.

final class VaccineLookupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<HealthLookup>>,
          List<HealthLookup>,
          FutureOr<List<HealthLookup>>
        >
    with
        $FutureModifier<List<HealthLookup>>,
        $FutureProvider<List<HealthLookup>> {
  /// Known vaccine names for the add-vaccination picker.
  VaccineLookupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vaccineLookupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vaccineLookupsHash();

  @$internal
  @override
  $FutureProviderElement<List<HealthLookup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<HealthLookup>> create(Ref ref) {
    return vaccineLookups(ref);
  }
}

String _$vaccineLookupsHash() => r'eca444075e407435838c8b6d2368f0d1823fe233';

/// The pet's server-computed health score. Family-keyed per pet. Invalidate it
/// alongside [petHealthSnapshotProvider] after the user logs data — the score
/// is live and will move.

@ProviderFor(petHealthScore)
final petHealthScoreProvider = PetHealthScoreFamily._();

/// The pet's server-computed health score. Family-keyed per pet. Invalidate it
/// alongside [petHealthSnapshotProvider] after the user logs data — the score
/// is live and will move.

final class PetHealthScoreProvider
    extends
        $FunctionalProvider<
          AsyncValue<PetHealthScore>,
          PetHealthScore,
          FutureOr<PetHealthScore>
        >
    with $FutureModifier<PetHealthScore>, $FutureProvider<PetHealthScore> {
  /// The pet's server-computed health score. Family-keyed per pet. Invalidate it
  /// alongside [petHealthSnapshotProvider] after the user logs data — the score
  /// is live and will move.
  PetHealthScoreProvider._({
    required PetHealthScoreFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'petHealthScoreProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$petHealthScoreHash();

  @override
  String toString() {
    return r'petHealthScoreProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PetHealthScore> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PetHealthScore> create(Ref ref) {
    final argument = this.argument as int;
    return petHealthScore(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PetHealthScoreProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$petHealthScoreHash() => r'28c2beaf4e1737d66604dda58c0aae98adb1d3e7';

/// The pet's server-computed health score. Family-keyed per pet. Invalidate it
/// alongside [petHealthSnapshotProvider] after the user logs data — the score
/// is live and will move.

final class PetHealthScoreFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PetHealthScore>, int> {
  PetHealthScoreFamily._()
    : super(
        retry: null,
        name: r'petHealthScoreProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// The pet's server-computed health score. Family-keyed per pet. Invalidate it
  /// alongside [petHealthSnapshotProvider] after the user logs data — the score
  /// is live and will move.

  PetHealthScoreProvider call(int petId) =>
      PetHealthScoreProvider._(argument: petId, from: this);

  @override
  String toString() => r'petHealthScoreProvider';
}
