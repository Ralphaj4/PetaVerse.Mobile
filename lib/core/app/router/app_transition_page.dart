import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The app-wide page transition: a full slide in from the side edge.
///
/// Every GoRoute must build its page with [AppTransitionPage] so the whole
/// app navigates with one consistent motion. RTL locales slide from the
/// opposite edge automatically.
class AppTransitionPage<T> extends CustomTransitionPage<T> {
  const AppTransitionPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
  }) : super(
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: _buildTransition,
        );

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final begin = Offset(isRtl ? -1.0 : 1.0, 0);
    const end = Offset.zero;
    const curve = Curves.ease;

    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    final offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}

/// A plain fade, used when a Hero animation should carry the motion
/// (e.g. the shared full-screen map expanding from an inline preview).
/// A slide would fight the Hero, so the page itself only cross-fades.
class AppFadeTransitionPage<T> extends CustomTransitionPage<T> {
  const AppFadeTransitionPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
  }) : super(
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 350),
          transitionsBuilder: _buildTransition,
        );

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}

/// Exception to the app-wide transition, used only by the center paw
/// button: the screen glides up from behind the bottom navigation bar.
class AppSlideUpTransitionPage<T> extends CustomTransitionPage<T> {
  const AppSlideUpTransitionPage({
    required super.child,
    super.key,
    super.name,
    super.arguments,
  }) : super(
          transitionDuration: const Duration(milliseconds: 600),
          reverseTransitionDuration: const Duration(milliseconds: 550),
          transitionsBuilder: _buildTransition,
        );

  static Widget _buildTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final curved = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(curved);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
