import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_client.dart';
import '../../../../core/storage/hive_service.dart';
import '../../../pawcare/presentation/providers/pawcare_providers.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../../data/datasources/home_local_datasource.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/home_summary.dart';
import '../../domain/repositories/home_repository.dart';

part 'home_providers.g.dart';

@Riverpod(keepAlive: true)
HomeLocalDataSource homeSummaryCache(Ref ref) =>
    HomeLocalDataSource(ref.watch(hiveServiceProvider));

@Riverpod(keepAlive: true)
HomeRepository homeRepository(Ref ref) => HomeRepositoryImpl(
      HomeRemoteDataSource(ref.watch(apiClientProvider)),
      ref.watch(homeSummaryCacheProvider),
      ref.watch(healthReminderCacheProvider),
    );

/// The aggregated home dashboard for the currently-selected pet (cards) plus
/// the cross-pet upcoming timeline. Re-fetches when the active pet changes so
/// the hero + stat cards follow the pet switcher; the timeline is always all
/// pets regardless of selection.
///
/// Offline-first: yields the cached snapshot immediately (instant paint), then
/// the fresh network result to reconcile. The repository also returns cache on
/// a network failure, so an offline refresh keeps the last snapshot rather than
/// erroring.
@riverpod
Stream<HomeSummary> homeSummary(Ref ref) async* {
  final petId = ref.watch(petsProvider).currentPetId;
  final repo = ref.watch(homeRepositoryProvider);

  // 1) Paint whatever we cached last, if anything.
  final cached = await repo.getCachedHomeSummary(petId: petId);
  if (cached != null) yield cached;

  // 2) Fetch fresh and reconcile. Suppress a network failure when we already
  //    showed cache; otherwise surface it.
  final result = await repo.getHomeSummary(petId: petId);
  yield* result.when(
    success: Stream.value,
    failure: (f) => cached != null ? const Stream.empty() : Stream.error(f),
  );
}
