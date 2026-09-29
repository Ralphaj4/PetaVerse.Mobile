import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Neutral launch screen shown while the app resolves which destination
/// to open (onboarding vs. login vs. home). It never flashes a real
/// screen: the router parks here until the onboarding + session gates
/// have loaded, then redirects to the correct route.
///
/// The logo pulses (zooms in and out) continuously to signal activity in
/// place of a spinner.
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _scale = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        // The logo itself pulses (zooms in and out) to signal activity.
        child: ScaleTransition(
          scale: _scale,
          child: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
