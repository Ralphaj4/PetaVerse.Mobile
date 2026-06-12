import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../dev/sandbox_page.dart';
import '../../widgets/coming_soon_page.dart';
import '../../widgets/home_placeholder_page.dart';
import '../app_shell.dart';
import 'app_transition_page.dart';

part 'app_router.g.dart';

/// Route paths, centralized. Feature code navigates with these, never
/// with Navigator.push.
abstract final class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String community = '/community';
  static const String care = '/care';
  static const String profile = '/profile';
  static const String services = '/services';
  static const String assistant = '/assistant';
  static const String sandbox = '/sandbox';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey();

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Watch onboarding state — when it changes Riverpod recreates this provider,
  // which rebuilds GoRouter with the updated redirect logic.
  final onboardingAsync = ref.watch(onboardingCompletedProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      // While still loading, don't redirect — stay wherever we are.
      if (onboardingAsync.isLoading) return null;
      final completed = onboardingAsync.value ?? true;
      final onOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!completed && !onOnboarding) return AppRoutes.onboarding;
      if (completed && onOnboarding) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const OnboardingPage(),
            ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: 'home',
                pageBuilder: (context, state) => AppTransitionPage(
                      key: state.pageKey,
                      child: const HomePlaceholderPage(),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.community,
                name: 'community',
                pageBuilder: (context, state) => AppTransitionPage(
                      key: state.pageKey,
                      child: const ComingSoonPage(title: 'PawHub'),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.care,
                name: 'care',
                pageBuilder: (context, state) => AppTransitionPage(
                      key: state.pageKey,
                      child: const ComingSoonPage(title: 'PawCare'),
                    ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: 'profile',
                pageBuilder: (context, state) => AppTransitionPage(
                      key: state.pageKey,
                      child: const ComingSoonPage(title: 'Profile'),
                    ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.services,
        name: 'services',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const ComingSoonPage(title: 'Services'),
            ),
      ),
      GoRoute(
        path: AppRoutes.assistant,
        name: 'assistant',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
              key: state.pageKey,
              child: const ComingSoonPage(title: 'AI Assistant', isModal: true),
            ),
      ),
      GoRoute(
        path: AppRoutes.sandbox,
        name: 'sandbox',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const SandboxPage(),
            ),
      ),
    ],
  );
}
