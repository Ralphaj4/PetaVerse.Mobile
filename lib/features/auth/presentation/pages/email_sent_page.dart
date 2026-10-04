import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import 'set_new_password_page.dart';

const int _smsCooldownSeconds = 120;

/// Args carried into the email-sent confirmation screen.
class EmailSentArgs {
  const EmailSentArgs({required this.phone});
  final String phone;
}

/// Shown after a forgot-password request results in an email reset link being
/// sent. Displays a prominent email icon, an explanatory message, and a timed
/// "Verify with SMS" fallback that becomes tappable after two minutes.
class EmailSentPage extends ConsumerStatefulWidget {
  const EmailSentPage({required this.phone, super.key});

  final String phone;

  @override
  ConsumerState<EmailSentPage> createState() => _EmailSentPageState();
}

class _EmailSentPageState extends ConsumerState<EmailSentPage> {
  int _secondsLeft = _smsCooldownSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _smsCooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String _formatSeconds(int s) {
    final m = s ~/ 60;
    final sec = s % 60;
    return '$m:${sec.toString().padLeft(2, '0')}';
  }

  Future<void> _verifySms() async {
    if (_secondsLeft > 0) return;
    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.forgotPassword(
      phone: widget.phone,
      requestOtp: true,
    );
    if (!mounted) return;
    if (result.ok) {
      // Replace this page so back from the combined OTP+password page
      // returns to forgot_password, not email_sent.
      context.pushReplacement(
        AppRoutes.setNewPassword,
        extra: SetNewPasswordArgs(
          phone: widget.phone,
          // code is null - the OTP field is shown inline on SetNewPasswordPage.
        ),
      );
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
    final canSms = _secondsLeft == 0 && !isLoading;

    return AuthLayout(
      showBack: true,
      titleTop: l10n.emailSentTitle1,
      titleAccent: l10n.emailSentTitle2,
      subtitle: l10n.emailSentSubtitle,
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.xxl),
          const Icon(
            FluentIcons.mail_24_regular,
            size: 80,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            l10n.emailSentBody,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          GestureDetector(
            onTap: canSms ? _verifySms : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _secondsLeft > 0
                      ? l10n.verifySmsIn(_formatSeconds(_secondsLeft))
                      : l10n.verifyWithSms,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: canSms
                        ? AppColors.primary
                        : AppColors.textTertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_secondsLeft == 0) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    FluentIcons.chevron_right_24_regular,
                    size: 16,
                    color: canSms ? AppColors.primary : AppColors.textTertiary,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
