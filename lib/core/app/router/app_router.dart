import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/presentation/pages/avatar_setup_page.dart';
import '../../../features/auth/presentation/pages/change_password_page.dart';
import '../../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../../features/auth/presentation/pages/login_page.dart';
import '../../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/assistant/presentation/pages/assistant_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/lost_and_found/presentation/pages/lost_and_found_page.dart';
import '../../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../../features/pets/domain/entities/pet_ref.dart';
import '../../../features/pets/presentation/pages/create_pet_page.dart';
import '../../../features/pets/presentation/pages/edit_pet_page.dart';
import '../../../features/pets/presentation/pages/pet_avatar_setup_page.dart';
import '../../../features/pets/presentation/pages/pet_detail_page.dart';
import '../../../features/pets/presentation/pages/pet_list_page.dart';
import '../../../features/pets/presentation/pages/pet_onboarding_page.dart';
import '../../../features/pets/presentation/pages/select_pet_page.dart';
import '../../../features/pet_vision/presentation/pages/pet_vision_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/profile/presentation/pages/personal_information_page.dart';
import '../../../features/profile/presentation/pages/change_language_page.dart';
import '../../../features/auth/presentation/providers/session_provider.dart';
import '../../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../../features/pets/presentation/providers/pets_provider.dart';
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
  static const String avatarSetup = '/avatar-setup';
  static const String forgotPassword = '/forgot-password';
  static const String changePassword = '/change-password';
  static const String petOnboarding = '/pet-onboarding';
  static const String createPet = '/create-pet';
  static String petAvatarSetupPath(int id) => '/pet-avatar-setup/$id';
  static const String petAvatarSetup = '/pet-avatar-setup/:id';
  static const String selectPet = '/select-pet';
  static const String petList = '/pet-list';
  static String petDetailPath(int id) => '/pet-detail/$id';
  static const String petDetail = '/pet-detail/:id';
  static String editPetPath(int id) => '/edit-pet/$id';
  static const String editPet = '/edit-pet/:id';
  static const String home = '/home';
  static const String community = '/community';
  static const String care = '/care';
  static const String profile = '/profile';
  static const String personalInformation = '/personal-information';
  static const String changeLanguage = '/change-language';
  static const String services = '/services';
  static const String assistant = '/assistant';
  static const String lostAndFound = '/lost-and-found';
  static const String map = '/map';
  static const String petVision = '/pet-vision';
  static const String sandbox = '/sandbox';
}

/// The route a logged-in user should land on, given the RESOLVED pet gate.
///
/// Assumes the gate is ready (callers that may run mid-resolve handle that
/// first). The post-auth fork:
///   • no pet (or unconfirmed-empty offline) → pet onboarding,
///   • 2+ pets with none chosen yet → the selection page,
///   • a pet selected (incl. an auto-selected single pet) → home.
String petLandingFor(PetsState pets) {
  if (pets.unresolvedEmpty || !pets.hasPets) return AppRoutes.petOnboarding;
  if (pets.currentPetId == null) return AppRoutes.selectPet;
  return AppRoutes.home;
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
    ..listen(sessionProvider, (_, _) => refresh.value++)
    ..listen(petsProvider, (_, _) => refresh.value++);

  // Routes reachable while signed out (the auth flow itself).
  const authRoutes = {
    AppRoutes.login,
    AppRoutes.register,
    AppRoutes.otp,
    AppRoutes.avatarSetup,
    AppRoutes.forgotPassword,
  };

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final onboardingAsync = ref.read(onboardingCompletedProvider);
      final session = ref.read(sessionProvider);
      final pets = ref.read(petsProvider);
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
      final onPetOnboarding = location == AppRoutes.petOnboarding;
      final onSelectPet = location == AppRoutes.selectPet;
      final onAvatarSetup = location == AppRoutes.avatarSetup;
      // The create-pet form is part of the "no pet yet" flow, so a pet-less
      // user is allowed to sit on it without being bounced to onboarding.
      // Avatar setup is also part of the post-register flow. Pet avatar setup
      // follows create-pet (before the gate is committed), so it must be
      // allowed too — match on the prefix since it carries a :id segment.
      final onPetAvatarSetup = location.startsWith('/pet-avatar-setup/');
      final onPetCreation = onPetOnboarding ||
          location == AppRoutes.createPet ||
          onAvatarSetup ||
          onPetAvatarSetup;

      // The post-auth landing for a logged-in user. The pet gate must resolve
      // BEFORE we ever allow /home — otherwise home flashes for a frame before
      // being replaced. While the gate is still resolving we hold on the splash
      // (a neutral screen), never on home.
      String petLanding() =>
          pets.ready ? petLandingFor(pets) : AppRoutes.splash;

      // Resolve the splash to the correct first destination.
      if (onSplash) {
        if (!completed) return AppRoutes.onboarding;
        if (!loggedIn) return AppRoutes.login;
        final landing = petLanding();
        // Already on splash and still resolving → stay put (no self-redirect).
        return landing == AppRoutes.splash ? null : landing;
      }

      // 1. Onboarding gate — must finish onboarding first.
      if (!completed) return onOnboarding ? null : AppRoutes.onboarding;
      if (onOnboarding) {
        if (!loggedIn) return AppRoutes.login;
        return petLanding();
      }

      // 2. Auth gate — protect everything except the auth flow.
      if (!loggedIn && !onAuthRoute) return AppRoutes.login;
      // Logged in but still on an auth route: the auth page resolves the pet
      // gate itself and then navigates directly to the landing. Hold on the
      // auth screen (its spinner is up) until it does — never bounce to the
      // splash, which would flash between login and the real destination.
      if (loggedIn && onAuthRoute) {
        // Avatar setup (post-register) is a special auth route that transitions
        // itself when ready — never bounce it to pet landing.
        if (onAvatarSetup) return null;
        if (!pets.ready) return null; // hold on the auth page; it will route.
        return petLanding();
      }

      // 3. Pet gate — decide where a logged-in user belongs.
      // Until the gate is ready, hold on the splash (cold start already shows
      // it) so /home can never render before the gate decides.
      if (loggedIn) {
        if (!pets.ready) return onSplash ? null : AppRoutes.splash;

        // No pet (or unconfirmed-empty offline): the pet-creation flow only.
        if (pets.unresolvedEmpty || !pets.hasPets) {
          return onPetCreation ? null : AppRoutes.petOnboarding;
        }

        // Has pets but none chosen yet (2+): the selection page only.
        if (pets.currentPetId == null) {
          return onSelectPet ? null : AppRoutes.selectPet;
        }

        // A pet is selected: the onboarding / selection screens no longer
        // apply — send those back to home; everything else is allowed.
        if (onPetOnboarding || onSelectPet) return AppRoutes.home;
      }

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
              isRegister: args.isRegister,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.avatarSetup,
        name: 'avatar-setup',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: const AvatarSetupPage(),
        ),
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
      GoRoute(
        path: AppRoutes.petOnboarding,
        name: 'petOnboarding',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const PetOnboardingPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.createPet,
        name: 'createPet',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const CreatePetPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.petAvatarSetup,
        name: 'petAvatarSetup',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final petId = int.parse(state.pathParameters['id']!);
          final petRef = state.extra as PetRef?;
          return AppTransitionPage(
            key: state.pageKey,
            child: PetAvatarSetupPage(petId: petId, petRef: petRef),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.selectPet,
        name: 'selectPet',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const SelectPetPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.petDetail,
        name: 'petDetail',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AppTransitionPage(
            key: state.pageKey,
            child: PetDetailPage(petId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.petList,
        name: 'petList',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const PetListPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.editPet,
        name: 'editPet',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AppTransitionPage(
            key: state.pageKey,
            child: EditPetPage(petId: id),
          );
        },
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
        path: AppRoutes.personalInformation,
        name: 'personalInformation',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const PersonalInformationPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.changeLanguage,
        name: 'changeLanguage',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const ChangeLanguagePage(),
            ),
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
        path: AppRoutes.petVision,
        name: 'petVision',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const PetVisionPage(),
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
