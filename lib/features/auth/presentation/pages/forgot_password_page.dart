import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/otp_input.dart';

const int _otpLength = 4;

/// Self-contained password-reset flow:
///   1. enter mobile number → backend sends an OTP
///   2. enter the OTP + a new password → reset, return to login
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() =>
      _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final GlobalKey<FormBuilderState> _phoneKey = GlobalKey<FormBuilderState>();
  final GlobalKey<FormBuilderState> _resetKey = GlobalKey<FormBuilderState>();

  String _completePhone = '';
  bool _codeSent = false;
  String _code = '';
  bool _obscure = true;
  bool _obscureConfirm = true;
  String? _devOtp;

  Future<void> _sendCode() async {
    if (!_phoneKey.currentState!.saveAndValidate()) return;
    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.forgotPassword(phone: _completePhone);
    if (!mounted) return;
    if (result.ok) {
      setState(() {
        _codeSent = true;
        _devOtp = result.devOtp;
      });
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        // A 404 here means the mobile number isn't registered — show a
        // clearer message than the generic not-found copy.
        final message = failure is NotFoundFailure
            ? context.l10n.errorPhoneNotRegistered
            : failure.localizedMessage(context.l10n);
        context.showSnackBar(message);
      }
    }
  }

  Future<void> _reset() async {
    if (!_resetKey.currentState!.saveAndValidate()) return;
    if (_code.length != _otpLength) return;
    final notifier = ref.read(authProvider.notifier);
    final ok = await notifier.resetPassword(
      phone: _completePhone,
      code: _code,
      newPassword: _resetKey.currentState!.value['newPassword'] as String,
    );
    if (!mounted) return;
    if (ok) {
      context.showSnackBar(context.l10n.passwordResetSuccess);
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
    final isLoading = ref.watch(authProvider).isLoading;

    return AuthLayout(
      showBack: true,
      titleTop:
          _codeSent ? l10n.resetPasswordTitle1 : l10n.forgotPasswordTitle1,
      titleAccent:
          _codeSent ? l10n.resetPasswordTitle2 : l10n.forgotPasswordTitle2,
      subtitle: _codeSent
          ? l10n.resetPasswordSubtitle(_completePhone)
          : l10n.forgotPasswordSubtitle,
      child: _codeSent
          ? _buildResetForm(isLoading)
          : _buildPhoneForm(isLoading),
    );
  }

  Widget _buildPhoneForm(bool isLoading) {
    return FormBuilder(
      key: _phoneKey,
      child: Column(
        children: [
          IntlPhoneField(
            decoration: InputDecoration(labelText: context.l10n.mobileNumber),
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
    );
  }

  Widget _buildResetForm(bool isLoading) {
    return FormBuilder(
      key: _resetKey,
      child: Column(
        children: [
          if (kDebugMode && _devOtp != null && _devOtp!.isNotEmpty) ...[
            _DevOtpBanner(otp: _devOtp!),
            const SizedBox(height: AppSpacing.lg),
          ],
          OtpInput(
            length: _otpLength,
            onChanged: (code) => setState(() => _code = code),
          ),
          const SizedBox(height: AppSpacing.xxl),
          FormBuilderTextField(
            name: 'newPassword',
            obscureText: _obscure,
            decoration: InputDecoration(
              labelText: context.l10n.newPassword,
              suffixIcon: IconButton(
                onPressed: () => setState(() => _obscure = !_obscure),
                icon: Icon(
                  _obscure
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(
                errorText: context.l10n.fieldRequired,
              ),
              FormBuilderValidators.minLength(
                8,
                errorText: context.l10n.passwordTooShort,
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),
          FormBuilderTextField(
            name: 'confirmPassword',
            obscureText: _obscureConfirm,
            decoration: InputDecoration(
              labelText: context.l10n.confirmPassword,
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                icon: Icon(
                  _obscureConfirm
                      ? FluentIcons.eye_24_regular
                      : FluentIcons.eye_off_24_regular,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return context.l10n.fieldRequired;
              }
              final newPass =
                  _resetKey.currentState?.fields['newPassword']?.value
                      as String?;
              if (value != newPass) return context.l10n.passwordsDoNotMatch;
              return null;
            },
          ),
          const SizedBox(height: AppSpacing.xxl),
          AuthSubmitButton(
            label: context.l10n.resetPasswordAction,
            isLoading: isLoading,
            onPressed: _code.length == _otpLength ? _reset : null,
          ),
        ],
      ),
    );
  }
}

/// Debug-only banner echoing the dev OTP returned by the backend.
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
