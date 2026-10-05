import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../shared/widgets/captcha_challenge.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../../../../core/app/router/app_router.dart';
import 'email_sent_page.dart';
import 'set_new_password_page.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final GlobalKey<FormBuilderState> _phoneKey = GlobalKey<FormBuilderState>();
  String _completePhone = '';

  Future<void> _sendCode({bool captchaAcknowledged = false}) async {
    if (!_phoneKey.currentState!.saveAndValidate()) return;
    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.forgotPassword(
      phone: _completePhone,
      captchaAcknowledged: captchaAcknowledged,
    );
    if (!mounted) return;
    if (result.captchaRequired) {
      final passed = await showCaptchaChallenge(context);
      if (!mounted) return;
      if (passed) await _sendCode(captchaAcknowledged: true);
      return;
    }
    if (result.ok) {
      if (result.isOtp) {
        unawaited(context.push(
          AppRoutes.setNewPassword,
          extra: SetNewPasswordArgs(phone: _completePhone),
        ));
      } else {
        unawaited(context.push(
          AppRoutes.emailSent,
          extra: EmailSentArgs(phone: _completePhone),
        ));
      }
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        final message = failure is NotFoundFailure
            ? context.l10n.errorPhoneNotRegistered
            : failure.localizedMessage(context.l10n);
        context.showSnackBar(message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = ref.watch(authProvider).isLoading;

    return AuthLayout(
      showBack: true,
      titleTop: l10n.forgotPasswordTitle1,
      titleAccent: l10n.forgotPasswordTitle2,
      subtitle: l10n.forgotPasswordSubtitle,
      child: FormBuilder(
        key: _phoneKey,
        child: Column(
          children: [
            IntlPhoneField(
              decoration:
                  InputDecoration(labelText: context.l10n.mobileNumber),
              initialCountryCode: 'LB',
              languageCode: Localizations.localeOf(context).languageCode,
              invalidNumberMessage: context.l10n.invalidPhone,
              dropdownIcon: const Icon(
                FluentIcons.chevron_down_24_regular,
                size: 18,
                color: AppColors.textSecondary,
              ),
              onChanged: (phone) => _completePhone = phone.completeNumber,
            ),
            const SizedBox(height: AppSpacing.xxl),
            AuthSubmitButton(
              label: context.l10n.sendCode,
              isLoading: isLoading,
              onPressed: _sendCode,
            ),
          ],
        ),
      ),
    );
  }
}
