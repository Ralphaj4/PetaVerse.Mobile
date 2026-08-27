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
import '../../../features/home/presentation/pages/upcoming_reminders_page.dart';
import '../../../features/lost_and_found/presentation/models/pet_alert.dart';
import '../../../features/lost_and_found/presentation/pages/lost_and_found_detail_page.dart';
import '../../../features/lost_and_found/presentation/pages/lost_and_found_page.dart';
import '../../../features/lost_and_found/presentation/pages/report_lost_pet_page.dart';
import '../../../features/adoption/domain/entities/adoption_listing.dart';
import '../../../features/adoption/presentation/pages/adoption_board_page.dart';
import '../../../features/adoption/presentation/pages/adoption_listing_detail_page.dart';
import '../../../features/adoption/presentation/pages/adoption_rehome_success_page.dart';
import '../../../features/adoption/presentation/pages/adoption_welcome_page.dart';
import '../../../features/adoption/presentation/pages/list_pet_for_adoption_page.dart';
import '../../../features/adoption/presentation/pages/manage_applicants_page.dart';
import '../../../features/adoption/presentation/pages/my_adoptions_page.dart';
import '../../../features/co_ownership/presentation/pages/co_owner_invitations_page.dart';
import '../../../features/co_ownership/presentation/pages/invite_co_owner_page.dart';
import '../../../features/community/presentation/pages/communities_page.dart';
import '../../../features/community/presentation/pages/community_detail_page.dart';
import '../../../features/community/presentation/pages/community_hub_page.dart';
import '../../../features/community/presentation/pages/community_members_page.dart';
import '../../../features/community/presentation/pages/create_community_page.dart';
import '../../../features/community/presentation/pages/event_attendees_page.dart';
import '../../../features/community/presentation/pages/event_detail_page.dart';
import '../../../features/community/presentation/pages/pawhub_search_page.dart';
import '../../../features/community/presentation/pages/pawhub_saved_page.dart';
import '../../../features/community/presentation/pages/pawhub_my_posts_page.dart';
import '../../../features/community/presentation/pages/pawhub_hashtag_page.dart';
import '../../../features/community/presentation/pages/pawhub_post_detail_page.dart';
import '../../../features/community/presentation/pages/pawhub_followers_page.dart';
import '../../../features/community/presentation/pages/pawhub_following_page.dart';
import '../../../features/community/presentation/pages/pawhub_blocked_page.dart';
import '../../../features/community/presentation/pages/pawhub_trending_page.dart';
import '../../../features/community/presentation/pages/tag_pets_page.dart';
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
import '../../../features/activity/presentation/pages/walk_history_page.dart';
import '../../../features/notifications/presentation/pages/notifications_page.dart';
import '../../../features/profile/presentation/pages/notification_settings_page.dart';
import '../../../features/pawcare/presentation/pages/add_appointment_page.dart';
import '../../../features/pawcare/presentation/pages/edit_appointment_page.dart';
import '../../../features/pawcare/presentation/pages/add_medication_page.dart';
import '../../../features/pawcare/presentation/pages/add_vaccination_page.dart';
import '../../../features/pawcare/presentation/pages/add_weight_page.dart';
import '../../../features/pawcare/presentation/pages/appointments_list_page.dart';
import '../../../features/pawcare/domain/entities/appointment.dart';
import '../../../features/pawcare/presentation/pages/health_score_page.dart';
import '../../../features/pawcare/presentation/pages/medications_list_page.dart';
import '../../../features/pawcare/presentation/pages/vaccinations_list_page.dart';
import '../../../features/pawcare/presentation/pages/weight_history_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/profile/presentation/pages/personal_information_page.dart';
import '../../../features/service_providers/presentation/pages/service_providers_page.dart';
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
  static String inviteCoOwnerPath(int id) => '/pet-detail/$id/invite-co-owner';
  static const String inviteCoOwner = '/pet-detail/:id/invite-co-owner';
  static const String coOwnerInvitations = '/co-owner-invitations';
  static const String home = '/home';
  static const String community = '/community';
  static const String care = '/care';
  static const String profile = '/profile';
  static const String personalInformation = '/personal-information';
  static const String changeLanguage = '/change-language';
  static const String services = '/services';
  static const String assistant = '/assistant';
  static const String lostAndFound = '/lost-and-found';
  static const String reportLostPet = '/lost-and-found/report';
  static const String lostFoundDetail = '/lost-and-found/listing/:id';
  static const String adoptionBoard = '/adoption';
  static const String listPetForAdoption = '/adoption/list-a-pet';
  static const String adoptionDetail = '/adoption/listing/:id';
  static String adoptionDetailPath(int id) => '/adoption/listing/$id';
  static const String adoptionManage = '/adoption/listing/:id/applicants';
  static String adoptionManagePath(int id) =>
      '/adoption/listing/$id/applicants';
  static const String adoptionRehomeSuccess = '/adoption/rehomed';
  static const String adoptionMy = '/adoption/mine';
  static const String adoptionWelcome = '/adoption/welcome';
  static const String map = '/map';
  static const String petVision = '/pet-vision';
  static const String sandbox = '/sandbox';
  static const String tagPets = '/community/tag-pets';

  // PawCare — appointments (under a pet)
  static String addAppointmentPath(int petId) => '/pet/$petId/appointments/add';
  static const String addAppointment = '/pet/:id/appointments/add';
  static String appointmentsPath(int petId) => '/pet/$petId/appointments';
  static const String appointments = '/pet/:id/appointments';
  static String editAppointmentPath(int petId, int appointmentId) =>
      '/pet/$petId/appointments/$appointmentId/edit';
  static const String editAppointment = '/pet/:id/appointments/:apptId/edit';

  // PawCare health (under a pet)
  static String addWeightPath(int petId) => '/pet/$petId/weight/add';
  static const String addWeight = '/pet/:id/weight/add';
  static String weightHistoryPath(int petId) => '/pet/$petId/weight';
  static const String weightHistory = '/pet/:id/weight';
  static String addMedicationPath(int petId) => '/pet/$petId/medications/add';
  static const String addMedication = '/pet/:id/medications/add';
  static String medicationsPath(int petId) => '/pet/$petId/medications';
  static const String medications = '/pet/:id/medications';
  static String addVaccinationPath(int petId) =>
      '/pet/$petId/vaccinations/add';
  static const String addVaccination = '/pet/:id/vaccinations/add';
  static String vaccinationsPath(int petId) => '/pet/$petId/vaccinations';
  static const String vaccinations = '/pet/:id/vaccinations';
  static String healthScorePath(int petId) => '/pet/$petId/health-score';
  static const String healthScore = '/pet/:id/health-score';

  // Walk activity
  static String walkHistoryPath(int petId) => '/pet/$petId/walks';
  static const String walkHistory = '/pet/:id/walks';

  // Upcoming reminders (home)
  static const String upcomingReminders = '/upcoming';

  // Notification center
  static const String notifications = '/notifications';

  // Notification preferences
  static const String notificationSettings = '/notification-settings';
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
      // A pet-less user may also open their co-owner invitations from the
      // onboarding gate (accepting one is how they get their first pet).
      final onCoOwnerInvitations = location == AppRoutes.coOwnerInvitations;
      // A pet-less user may also browse the adoption board (and open a listing)
      // from the onboarding gate — adopting is a way to get their first pet.
      final onAdoption = location == AppRoutes.adoptionBoard ||
          location.startsWith('/adoption/');
      final onPetCreation = onPetOnboarding ||
          location == AppRoutes.createPet ||
          onAvatarSetup ||
          onPetAvatarSetup ||
          onCoOwnerInvitations ||
          onAdoption;

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

      // ── PawCare health (under a pet) ──────────────────────────────────────
      GoRoute(
        path: AppRoutes.weightHistory,
        name: 'weightHistory',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: WeightHistoryPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.addWeight,
        name: 'addWeight',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
          key: state.pageKey,
          child: AddWeightPage(petId: int.parse(state.pathParameters['id']!)),
        ),
      ),
      GoRoute(
        path: AppRoutes.medications,
        name: 'medications',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: MedicationsListPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.addMedication,
        name: 'addMedication',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
          key: state.pageKey,
          child: AddMedicationPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.vaccinations,
        name: 'vaccinations',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: VaccinationsListPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.addVaccination,
        name: 'addVaccination',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
          key: state.pageKey,
          child: AddVaccinationPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.addAppointment,
        name: 'addAppointment',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
          key: state.pageKey,
          child: AddAppointmentPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.editAppointment,
        name: 'editAppointment',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
          key: state.pageKey,
          child: EditAppointmentPage(
            petId: int.parse(state.pathParameters['id']!),
            appointment: state.extra as Appointment,
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.appointments,
        name: 'appointments',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: AppointmentsListPage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.healthScore,
        name: 'healthScore',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: HealthScorePage(
            petId: int.parse(state.pathParameters['id']!),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.upcomingReminders,
        name: 'upcomingReminders',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
          key: state.pageKey,
          child: const UpcomingRemindersPage(),
        ),
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
      GoRoute(
        path: AppRoutes.inviteCoOwner,
        name: 'inviteCoOwner',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          final petName = state.extra as String?;
          return AppTransitionPage(
            key: state.pageKey,
            child: InviteCoOwnerPage(petId: id, petName: petName),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.coOwnerInvitations,
        name: 'coOwnerInvitations',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const CoOwnerInvitationsPage(),
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
                      child: const CommunityHubPage(),
                    ),
                routes: [
                  GoRoute(
                    path: 'search',
                    name: 'community_search',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const PawHubSearchPage(),
                        ),
                  ),
                  GoRoute(
                    path: 'saved',
                    name: 'community_saved',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const PawHubSavedPage(),
                        ),
                  ),
                  GoRoute(
                    path: 'my-posts',
                    name: 'community_my_posts',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const PawHubMyPostsPage(),
                        ),
                  ),
                  GoRoute(
                    path: 'hashtag/:tag',
                    name: 'community_hashtag',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: PawHubHashtagPage(
                            hashtag: state.pathParameters['tag'] ?? '',
                          ),
                        ),
                  ),
                  GoRoute(
                    path: 'post/:id',
                    name: 'community_post',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: PawHubPostDetailPage(
                            postId:
                                int.tryParse(state.pathParameters['id'] ?? '') ??
                                    0,
                          ),
                        ),
                  ),
                  GoRoute(
                    path: 'pet/:id/followers',
                    name: 'community_followers',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: PawHubFollowersPage(
                            petId:
                                int.tryParse(state.pathParameters['id'] ?? '') ??
                                    0,
                          ),
                        ),
                  ),
                  GoRoute(
                    path: 'pet/:id/following',
                    name: 'community_following',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: PawHubFollowingPage(
                            petId:
                                int.tryParse(state.pathParameters['id'] ?? '') ??
                                    0,
                          ),
                        ),
                  ),
                  GoRoute(
                    path: 'blocked',
                    name: 'community_blocked',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const PawHubBlockedPage(),
                        ),
                  ),
                  GoRoute(
                    path: 'trending',
                    name: 'community_trending',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const PawHubTrendingPage(),
                        ),
                  ),
                  GoRoute(
                    path: 'communities',
                    name: 'communities',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: const CommunitiesPage(),
                        ),
                    routes: [
                      GoRoute(
                        path: 'create',
                        name: 'community_create',
                        pageBuilder: (context, state) => AppTransitionPage(
                              key: state.pageKey,
                              child: const CreateCommunityPage(),
                            ),
                      ),
                      GoRoute(
                        path: ':id',
                        name: 'community_detail',
                        pageBuilder: (context, state) => AppTransitionPage(
                              key: state.pageKey,
                              child: CommunityDetailPage(
                                communityId: int.tryParse(
                                        state.pathParameters['id'] ?? '') ??
                                    0,
                              ),
                            ),
                        routes: [
                          GoRoute(
                            path: 'members',
                            name: 'community_members',
                            pageBuilder: (context, state) => AppTransitionPage(
                                  key: state.pageKey,
                                  child: CommunityMembersPage(
                                    communityId: int.tryParse(
                                            state.pathParameters['id'] ?? '') ??
                                        0,
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Event detail + attendees (community-scoped but addressed by
                  // event id, so kept as siblings of the communities subtree).
                  GoRoute(
                    path: 'events/:eventId',
                    name: 'community_event_detail',
                    pageBuilder: (context, state) => AppTransitionPage(
                          key: state.pageKey,
                          child: EventDetailPage(
                            eventId: int.tryParse(
                                    state.pathParameters['eventId'] ?? '') ??
                                0,
                            communityId: (state.extra
                                    as EventDetailArgs?)?.communityId ??
                                0,
                            canManage:
                                (state.extra as EventDetailArgs?)?.canManage ??
                                    false,
                            communityName: (state.extra
                                    as EventDetailArgs?)?.communityName ??
                                '',
                          ),
                        ),
                    routes: [
                      GoRoute(
                        path: 'attendees',
                        name: 'community_event_attendees',
                        pageBuilder: (context, state) => AppTransitionPage(
                              key: state.pageKey,
                              child: EventAttendeesPage(
                                eventId: int.tryParse(
                                        state.pathParameters['eventId'] ??
                                            '') ??
                                    0,
                              ),
                            ),
                      ),
                    ],
                  ),
                ],
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
                      child: const ServiceProvidersPage(),
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
        path: AppRoutes.reportLostPet,
        name: 'reportLostPet',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const ReportLostPetPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.lostFoundDetail,
        name: 'lostFoundDetail',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          // The tapped alert (when navigated from a card) seeds the header and
          // powers the shared Hero while the full report loads.
          final initial = state.extra as PetAlert?;
          return AppTransitionPage(
            key: state.pageKey,
            child: LostFoundDetailPage(reportId: id, initialAlert: initial),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.adoptionBoard,
        name: 'adoptionBoard',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const AdoptionBoardPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.listPetForAdoption,
        name: 'listPetForAdoption',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppSlideUpTransitionPage(
              key: state.pageKey,
              child: const ListPetForAdoptionPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.adoptionDetail,
        name: 'adoptionDetail',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          // The tapped listing (when navigated from a card) seeds the header
          // and powers the shared Hero while the full listing loads.
          final initial = state.extra as AdoptionListing?;
          return AppTransitionPage(
            key: state.pageKey,
            child: AdoptionListingDetailPage(
              listingId: id,
              initialListing: initial,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.adoptionManage,
        name: 'adoptionManage',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          // The tapped listing (from the detail screen) seeds the pet header.
          final initial = state.extra as AdoptionListing?;
          return AppTransitionPage(
            key: state.pageKey,
            child: ManageApplicantsPage(
              listingId: id,
              initialListing: initial,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.adoptionRehomeSuccess,
        name: 'adoptionRehomeSuccess',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppFadeTransitionPage(
              key: state.pageKey,
              child: AdoptionRehomeSuccessPage(
                args: state.extra! as AdoptionRehomeSuccessArgs,
              ),
            ),
      ),
      GoRoute(
        path: AppRoutes.adoptionMy,
        name: 'adoptionMy',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const MyAdoptionsPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.adoptionWelcome,
        name: 'adoptionWelcome',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppFadeTransitionPage(
              key: state.pageKey,
              child: AdoptionWelcomePage(
                args: state.extra! as AdoptionWelcomeArgs,
              ),
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
      GoRoute(
        path: AppRoutes.tagPets,
        name: 'tagPets',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: TagPetsPage(args: state.extra! as TagPetsArgs),
            ),
      ),
      GoRoute(
        path: AppRoutes.walkHistory,
        name: 'walkHistory',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final petId = int.parse(state.pathParameters['id']!);
          return AppTransitionPage(
            key: state.pageKey,
            child: WalkHistoryPage(petId: petId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const NotificationsPage(),
            ),
      ),
      GoRoute(
        path: AppRoutes.notificationSettings,
        name: 'notificationSettings',
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => AppTransitionPage(
              key: state.pageKey,
              child: const NotificationSettingsPage(),
            ),
      ),
    ],
  );
}
