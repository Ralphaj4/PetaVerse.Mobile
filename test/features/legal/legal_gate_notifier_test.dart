import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petaverse_mobile/core/errors/failure.dart';
import 'package:petaverse_mobile/core/errors/result.dart';
import 'package:petaverse_mobile/features/auth/presentation/providers/session_provider.dart';
import 'package:petaverse_mobile/features/home/domain/entities/home_summary.dart';
import 'package:petaverse_mobile/features/home/presentation/providers/home_providers.dart';
import 'package:petaverse_mobile/features/legal/domain/entities/legal.dart';
import 'package:petaverse_mobile/features/legal/domain/repositories/legal_repository.dart';
import 'package:petaverse_mobile/features/legal/presentation/providers/legal_providers.dart';
import 'package:petaverse_mobile/features/pawcare/domain/entities/pet_health_score.dart';
import 'package:riverpod/riverpod.dart';

class _MockLegalRepository extends Mock implements LegalRepository {}

/// A minimal fresh (non-cache) home summary carrying the given legal block.
HomeSummary _summary({HomeLegal? legal, bool fromCache = false}) => HomeSummary(
      petId: 1,
      petName: 'Milo',
      healthScore: 0,
      healthBand: HealthBand.noData,
      nextVisit: null,
      activity: const ActivityStat(minutes: 0, activeDays: 0, windowDays: 7),
      vaccinesUpcomingCount: 0,
      weight: null,
      upcoming: const [],
      legal: legal,
      fromCache: fromCache,
    );

void main() {
  late _MockLegalRepository repo;
  late StreamController<HomeSummary> home;

  setUp(() {
    repo = _MockLegalRepository();
    home = StreamController<HomeSummary>();
  });

  // Flush the stream → provider → ref.listen → notifier chain.
  Future<void> settle(ProviderContainer c) async {
    await Future<void>.delayed(Duration.zero);
    await c.pump();
    await Future<void>.delayed(Duration.zero);
  }

  tearDown(() => home.close());

  ProviderContainer makeContainer() {
    final container = ProviderContainer(
      overrides: [
        sessionProvider.overrideWithValue(
          const SessionState(ready: true, loggedIn: true),
        ),
        legalRepositoryProvider.overrideWithValue(repo),
        homeSummaryProvider.overrideWith((ref) => home.stream),
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  test('diagnostic: home-summary override emits into the container', () async {
    final container = makeContainer();
    final emissions = <AsyncValue<HomeSummary>>[];
    container.listen(homeSummaryProvider, (_, next) => emissions.add(next),
        fireImmediately: true);
    home.add(_summary(legal: const HomeLegal.none()));
    await settle(container);
    expect(emissions.whereType<AsyncData<HomeSummary>>(), isNotEmpty,
        reason: 'home-summary override must deliver the emitted value');
  });

  test(
      'home-summary requiresAcceptance:false seeds a pass-through gate with no '
      '/legal/status call', () async {
    final container = makeContainer();
    // Keep the gate alive with an active listener so its internal ref.listen
    // subscriptions stay wired for the duration of the test.
    container.listen(legalGateProvider, (_, _) {});

    home.add(_summary(legal: const HomeLegal.none()));
    await settle(container);

    final gate = container.read(legalGateProvider);
    expect(gate.ready, true);
    expect(gate.requiresAction, false);
    expect(gate.pending, isEmpty);
    // The whole point of the optimization: no standalone status round-trip.
    verifyNever(() => repo.getStatus());
  });

  test('home-summary requiresAcceptance:true routes to the wall', () async {
    final container = makeContainer();
    container.read(legalGateProvider);

    home.add(_summary(
      legal: const HomeLegal(
        requiresAcceptance: true,
        pending: [
          HomeLegalPending(
            documentType: LegalDocumentType.termsAndConditions,
            currentVersion: '2.0',
          ),
          HomeLegalPending(
            documentType: LegalDocumentType.privacyPolicy,
            currentVersion: '1.1',
          ),
        ],
      ),
    ));
    await settle(container);

    final gate = container.read(legalGateProvider);
    expect(gate.ready, true);
    expect(gate.requiresAction, true);
    expect(gate.pending.length, 2);
    expect(
      gate.pending.first.documentType,
      LegalDocumentType.termsAndConditions,
    );
    expect(gate.pending.first.currentVersion, '2.0');
    verifyNever(() => repo.getStatus());
  });

  test('a failed home-summary fails open (never traps) and falls back to status',
      () async {
    // Fallback /legal/status also fails → gate ready, reconcileFailed, but not
    // requiring action: the user is NOT trapped behind the wall.
    when(() => repo.getStatus()).thenAnswer(
      (_) async => const Result.failure(NetworkFailure()),
    );

    final container = makeContainer();
    container.read(legalGateProvider);

    home.addError(const NetworkFailure());
    await settle(container);
    // Give the fallback reconcile() an extra turn to complete.
    await settle(container);

    final gate = container.read(legalGateProvider);
    expect(gate.ready, true);
    expect(gate.requiresAction, false, reason: 'fail open - must not wall');
    verify(() => repo.getStatus()).called(1);
  });

  test('a cached home-summary is ignored (authoritative-only invariant)',
      () async {
    when(() => repo.getStatus()).thenAnswer(
      (_) async => const Result.success(LegalStatus(items: [])),
    );

    final container = makeContainer();
    container.read(legalGateProvider);

    // A cached snapshot that claims nothing is owed must NOT seed the gate.
    home.add(_summary(legal: const HomeLegal.none(), fromCache: true));
    await settle(container);

    final gate = container.read(legalGateProvider);
    // Not seeded from cache: the gate stays unready until an authoritative
    // source resolves it (here, nothing else did, so still not ready).
    expect(gate.ready, false);
    verifyNever(() => repo.getStatus());
  });
}
