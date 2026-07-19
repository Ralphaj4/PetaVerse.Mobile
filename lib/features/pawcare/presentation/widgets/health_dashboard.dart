import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/error_state_widget.dart';
import '../../domain/entities/medication.dart';
import '../providers/pawcare_providers.dart';
import 'health_section_skeleton.dart';
import 'medications_card.dart';
import 'vaccinations_card.dart';
import 'weight_card.dart';

/// The stacked health sections (weight, medications, vaccinations) shown on the
/// pet profile below the info card. Owns the async wiring so the profile page
/// only has to place it.
///
/// Each section's "add" opens the matching add-form; "mark given" hits the
/// real endpoint and refreshes the snapshot. Tapping a card header opens its
/// full history/list page.
class HealthDashboard extends ConsumerWidget {
  const HealthDashboard({required this.petId, super.key});

  final int petId;

  Future<void> _markGiven(
    BuildContext context,
    WidgetRef ref,
    Medication med,
  ) async {
    final l10n = context.l10n;
    final result = await ref
        .read(pawCareRepositoryProvider)
        .markMedicationGiven(petId, med.id);
    if (!context.mounted) return;
    result.when(
      success: (_) {
        ref.invalidate(petHealthSnapshotProvider(petId));
        ref.invalidate(petMedicationsProvider(petId));
        context.showSuccessSnackBar(
          l10n.healthMedicationsGivenConfirmed(med.name),
        );
      },
      failure: (f) => context.showErrorSnackBar(
        f.message?.isNotEmpty == true ? f.message! : l10n.errorUnknown,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshotAsync = ref.watch(petHealthSnapshotProvider(petId));

    return snapshotAsync.when(
      loading: () => const Column(
        children: [
          HealthSectionSkeleton(),
          SizedBox(height: AppSpacing.md),
          HealthSectionSkeleton(rows: 3),
          SizedBox(height: AppSpacing.md),
          HealthSectionSkeleton(rows: 3),
        ],
      ),
      error: (e, _) => ErrorStateWidget(
        failure: e is Failure ? e : null,
        onRetry: () => ref.invalidate(petHealthSnapshotProvider(petId)),
      ),
      data: (snapshot) => Column(
        children: [
          WeightCard(
            records: snapshot.weights,
            onAdd: () => context.push(AppRoutes.addWeightPath(petId)),
            onOpen: () => context.push(AppRoutes.weightHistoryPath(petId)),
          ),
          const SizedBox(height: AppSpacing.md),
          MedicationsCard(
            medications: snapshot.medications,
            onAdd: () => context.push(AppRoutes.addMedicationPath(petId)),
            onOpen: () => context.push(AppRoutes.medicationsPath(petId)),
            onMarkGiven: (m) => _markGiven(context, ref, m),
          ),
          const SizedBox(height: AppSpacing.md),
          VaccinationsCard(
            vaccinations: snapshot.vaccinations,
            onAdd: () => context.push(AppRoutes.addVaccinationPath(petId)),
            onOpen: () => context.push(AppRoutes.vaccinationsPath(petId)),
          ),
        ],
      ),
    );
  }
}
