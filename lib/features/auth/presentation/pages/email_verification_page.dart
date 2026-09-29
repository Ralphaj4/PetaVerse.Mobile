import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../profile/data/providers/user_repository_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/otp_input.dart';

const int _emailOtpLength = 6;
const int _resendCooldownSeconds = 60;

enum _SendState { loading, ready, alreadyVerified, failed }

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  ConsumerState<EmailVerificationPage> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState
    extends ConsumerState<EmailVerificationPage> {
  String _code = '';
  int _secondsLeft = _resendCooldownSeconds;
  Timer? _timer;
  _SendState _sendState = _SendState.loading;

  @override
  void initState() {
    super.initState();
    // Defer past the current build frame — Riverpod requires this before
    // any provider state mutation.
    Future(() => _requestCode());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _requestCode() async {
    setState(() => _sendState = _SendState.loading);
    final ok = await ref.read(authProvider.notifier).sendEmailVerification();
    if (!mounted) return;

    if (ok) {
      setState(() => _sendState = _SendState.ready);
      _startCooldown();
    } else {
      final failure = ref.read(authProvider.notifier).lastFailure;
      if (failure is ConflictFailure) {
        setState(() => _sendState = _SendState.alreadyVerified);
      } else {
        setState(() => _sendState = _SendState.failed);
      }
    }
  }

  void _startCooldown() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendCooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_secondsLeft <= 1) {
        t.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  Future<void> _verify() async {
    if (_code.length != _emailOtpLength) return;
    final notifier = ref.read(authProvider.notifier);
    final ok = await notifier.confirmEmailVerification(_code);
    if (!mounted) return;
    if (ok) {
      ref.invalidate(userRepositoryProvider);
      context.showSnackBar(context.l10n.emailVerifiedSuccess);
      context.pop();
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
    final isVerifying = ref.watch(authProvider).isLoading;

    return AuthLayout(
      showBack: true,
      titleTop: l10n.emailVerifyTitle1,
      titleAccent: l10n.emailVerifyTitle2,
      subtitle: l10n.emailVerifySubtitle,
      child: switch (_sendState) {
        _SendState.loading => const Center(
            child: CircularProgressIndicator(),
          ),
        _SendState.alreadyVerified => _InfoBanner(
            icon: FluentIcons.checkmark_circle_24_regular,
            color: AppColors.success,
            message: l10n.emailAlreadyVerified,
          ),
        _SendState.failed => _ErrorBanner(
            message: l10n.emailVerifySendFailed,
            onRetry: _requestCode,
          ),
        _SendState.ready => Column(
            children: [
              if (kDebugMode)
                _DevBanner(message: l10n.emailVerifyDevHint),
              const SizedBox(height: AppSpacing.lg),
              OtpInput(
                length: _emailOtpLength,
                onChanged: (v) => setState(() => _code = v),
                onCompleted: (_) => _verify(),
              ),
              const SizedBox(height: AppSpacing.xxl),
              AuthSubmitButton(
                label: l10n.verify,
                isLoading: isVerifying,
                onPressed: _code.length == _emailOtpLength && !isVerifying
                    ? _verify
                    : null,
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
                  onPressed: isVerifying ? null : _requestCode,
                  child: Text(l10n.resendCode),
                ),
            ],
          ),
      },
    );
  }
}

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({
    required this.icon,
    required this.color,
    required this.message,
  });

  final IconData icon;
  final Color color;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: AppRadius.smAll,
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.bodySmall.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.10),
        borderRadius: AppRadius.smAll,
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                FluentIcons.error_circle_24_regular,
                size: 18,
                color: AppColors.error,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style:
                      AppTextStyles.bodySmall.copyWith(color: AppColors.error),
                ),
              ),
            ],
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: onRetry,
              child: Text(
                context.l10n.retry,
                style: AppTextStyles.labelMedium
                    .copyWith(color: AppColors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DevBanner extends StatelessWidget {
  const _DevBanner({required this.message});

  final String message;

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
              message,
              style:
                  AppTextStyles.labelMedium.copyWith(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}
