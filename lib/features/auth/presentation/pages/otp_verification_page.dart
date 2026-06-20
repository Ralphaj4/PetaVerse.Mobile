import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/otp_input.dart';

const int _otpLength = 4;
const int _resendCooldownSeconds = 30;

/// Arguments for the OTP route: the phone to verify and, in Development,
/// the OTP echoed back by the backend so testers don't need a real SMS.
class OtpArgs {
  const OtpArgs({required this.phone, this.devOtp});

  final String phone;
  final String? devOtp;
}

class OtpVerificationPage extends ConsumerStatefulWidget {
  const OtpVerificationPage({required this.phone, this.devOtp, super.key});

  final String phone;
  final String? devOtp;

  @override
  ConsumerState<OtpVerificationPage> createState() =>
      _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  String _code = '';
  int _secondsLeft = _resendCooldownSeconds;
  Timer? _timer;
  String? _devOtp;

  @override
  void initState() {
    super.initState();
    _devOtp = widget.devOtp;
    _startCooldown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendCooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verify() async {
    if (_code.length != _otpLength) return;
    final notifier = ref.read(authProvider.notifier);
    final ok = await notifier.verifyOtp(phone: widget.phone, code: _code);
    if (!mounted) return;
    if (ok) {
      // Resolve the pet gate before navigating so we land directly on the
      // right screen (a just-registered user goes to pet-onboarding).
      await ref.read(petsProvider.notifier).reconcile();
      if (!mounted) return;
      context.go(petLandingFor(ref.read(petsProvider)));
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        context.showSnackBar(failure.localizedMessage(context.l10n));
      }
    }
  }

  Future<void> _resend() async {
    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.resendOtp(phone: widget.phone);
    if (!mounted) return;
    if (result.ok) {
      setState(() => _devOtp = result.devOtp);
      _startCooldown();
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        context.showSnackBar(failure.localizedMessage(context.l10n));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = ref.watch(authProvider).isLoading;

    return AuthLayout(
      showBack: true,
      titleTop: l10n.otpTitle1,
      titleAccent: l10n.otpTitle2,
      subtitle: l10n.otpSubtitle(widget.phone),
      child: Column(
        children: [
          if (kDebugMode && _devOtp != null && _devOtp!.isNotEmpty) ...[
            _DevOtpBanner(otp: _devOtp!),
            const SizedBox(height: AppSpacing.lg),
          ],
          OtpInput(
            length: _otpLength,
            onChanged: (code) => setState(() => _code = code),
            onCompleted: (_) => _verify(),
          ),
          const SizedBox(height: AppSpacing.xxl),
          AuthSubmitButton(
            label: l10n.verify,
            isLoading: isLoading,
            onPressed: _code.length == _otpLength ? _verify : null,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_secondsLeft > 0)
            Text(
              l10n.resendIn(_secondsLeft),
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textTertiary,
              ),
            )
          else
            TextButton(
              onPressed: isLoading ? null : _resend,
              child: Text(l10n.resendCode),
            ),
        ],
      ),
    );
  }
}

/// Debug-only banner showing the OTP the Development backend returned, so
/// testers can verify without a real SMS. Never built in release.
class _DevOtpBanner extends StatelessWidget {
  const _DevOtpBanner({required this.otp});

  final String otp;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.12),
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(
            FluentIcons.wrench_24_regular,
            size: 18,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'DEV OTP: $otp',
              style: AppTextStyles.titleSmall.copyWith(
                color: AppColors.warning,
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
