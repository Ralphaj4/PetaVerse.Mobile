import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/presentation/pages/change_password_page.dart';
import '../../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/assistant/presentation/pages/assistant_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/lost_and_found/presentation/pages/lost_and_found_page.dart';
import '../../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/auth/presentation/providers/session_provider.dart';
import '../../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../dev/sandbox_page.dart';
import '../../widgets/coming_soon_page.dart';
import '../../widgets/map/map_page.dart';
import '../../widgets/splash_page.dart';
import '../app_shell.dart';
import 'app_transition_page.dart';

part 'app_router.g.dart';

/// Route paths, centralized. Feature code navigates with these, never
/// with Navigator.push.
abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String home = '/home';
  static const String community = '/community';
  static const String care = '/care';
  static const String profile = '/profile';
  static const String services = '/services';
  static const String assistant = '/assistant';
  static const String lostAndFound = '/lost-and-found';
  static const String map = '/map';
  static const String sandbox = '/sandbox';
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey();

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  // Re-run the redirect when onboarding OR session state changes, WITHOUT
  // recreating the router (recreation would reset the navigation stack).
  final refresh = ValueNotifier(0);
  ref
    ..onDispose(refresh.dispose)
    ..listen(onboardingCompletedProvider, (_, _) => refresh.value++)
    ..listen(sessionProvider, (_, _) => refresh.value++);

  // Routes reachable while signed out (the auth flow itself).
  const authRoutes = {
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.otp,
    AppRoutes.forgotPassword,
  };

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboardingAsync = ref.read(onboardingCompletedProvider);
      final session = ref.read(sessionProvider);
      final location = state.matchedLocation;
      final onSplash = location == AppRoutes.splash;

      // While either gate is resolving, stay put (return null). On cold start
      // that means holding on the splash (initialLocation) until both gates
      // are ready — so a real screen never flashes first.
      if (onboardingAsync.isLoading || !session.ready) return null;

      final completed = onboardingAsync.value ?? true;
      final loggedIn = session.loggedIn;
      final onOnboarding = location == AppRoutes.onboarding;
      final onAuthRoute = authRoutes.contains(location);

      // Resolve the splash to the correct first destination.
      if (onSplash) {
        if (!completed) return AppRoutes.onboarding;
        return loggedIn ? AppRoutes.home : AppRoutes.login;
      }

      // 1. Onboarding gate — must finish onboarding first.
      if (!completed) return onOnboarding ? null : AppRoutes.onboarding;
      if (onOnboarding) return loggedIn ? AppRoutes.home : AppRoutes.login;

      // 2. Auth gate — protect everything except the auth flow.
      if (!loggedIn && !onAuthRoute) return AppRoutes.login;
      if (loggedIn && onAuthRoute) return AppRoutes.home;

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppFadeTransitionPage(
              key: state.pageKey,
              child: const SplashPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        name: 'onboarding',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const OnboardingPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const LoginPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const RegisterPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.otp,
        name: 'otp',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final extra = state.extra;
          final args = switch (extra) {
            OtpArgs() => extra,
            String() => OtpArgs(phone: extra),
            _ => const OtpArgs(phone: ''),
          };
          return AppTransitionPage(
            key: state.pageKey,
            child: OtpVerificationPage(
              phone: args.phone,
              devOtp: args.devOtp,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        name: 'forgotPassword',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const ForgotPasswordPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.changePassword,
        name: 'changePassword',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const ChangePasswordPage(),
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
                      child: const HomePage(),
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
                      child: const ProfilePage(),
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
              child: const AssistantPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.lostAndFound,
        name: 'lostAndFound',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const LostAndFoundPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.map,
        name: 'map',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppFadeTransitionPage(
              key: state.pageKey,
              child: MapPage(args: state.extra! as MapPageArgs),
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
