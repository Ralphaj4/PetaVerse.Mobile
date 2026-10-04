import 'package:flutter/material.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/otp_input.dart';

const int _otpLength = 4;

/// Args passed via router extra to [SetNewPasswordPage].
///
/// [code] is null when coming from the SMS path - the OTP input is shown
/// inline on this page and collected before submitting.
class SetNewPasswordArgs {
  const SetNewPasswordArgs({required this.phone, this.code});
  final String phone;
  final String? code;
}

/// Final step of the forgot-password flow: enter the SMS OTP (when [code] is
/// null) and set a new password. Calls resetPassword, which validates the OTP
/// server-side at the same time.
class SetNewPasswordPage extends ConsumerStatefulWidget {
  const SetNewPasswordPage({
    required this.phone,
    this.code,
    super.key,
  });

  final String phone;

  /// Pre-filled OTP code when arriving from a future deep-link path.
  /// Null when the user enters the OTP inline on this page.
  final String? code;

  @override
  ConsumerState<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends ConsumerState<SetNewPasswordPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _obscure = true;
  bool _obscureConfirm = true;
  String _otp = '';

  bool get _needsOtp => widget.code == null;

  Future<void> _reset() async {
    if (!_formKey.currentState!.saveAndValidate()) return;
    final code = widget.code ?? _otp;
    if (code.length != _otpLength) {
      context.showSnackBar(context.l10n.otpInvalid);
      return;
    }
    final notifier = ref.read(authProvider.notifier);
    final ok = await notifier.resetPassword(
      phone: widget.phone,
      code: code,
      newPassword: _formKey.currentState!.value['newPassword'] as String,
    );
    if (!mounted) return;
    if (ok) {
      context.showSnackBar(context.l10n.passwordResetSuccess);
      context.go(AppRoutes.login);
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
    final canSubmit = (!_needsOtp || _otp.length == _otpLength) && !isLoading;

    return AuthLayout(
      showBack: true,
      titleTop: l10n.setNewPasswordTitle1,
      titleAccent: l10n.setNewPasswordTitle2,
      subtitle: l10n.resetPasswordSubtitle(widget.phone),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OTP input - only shown when arriving from the SMS path directly
            if (_needsOtp) ...[
              OtpInput(
                length: _otpLength,
                onChanged: (v) => setState(() => _otp = v),
                onCompleted: (_) => FocusScope.of(context).nextFocus(),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],

            FormBuilderTextField(
              name: 'newPassword',
              obscureText: _obscure,
              decoration: InputDecoration(
                labelText: l10n.newPassword,
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
                  errorText: l10n.fieldRequired,
                ),
                FormBuilderValidators.minLength(
                  8,
                  errorText: l10n.passwordTooShort,
                ),
              ]),
            ),
            const SizedBox(height: AppSpacing.lg),
            FormBuilderTextField(
              name: 'confirmPassword',
              obscureText: _obscureConfirm,
              decoration: InputDecoration(
                labelText: l10n.confirmPassword,
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
                if (value == null || value.isEmpty) return l10n.fieldRequired;
                final newPass =
                    _formKey.currentState?.fields['newPassword']?.value
                        as String?;
                if (value != newPass) return l10n.passwordsDoNotMatch;
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
            AuthSubmitButton(
              label: l10n.resetPasswordAction,
              isLoading: isLoading,
              onPressed: canSubmit ? _reset : null,
            ),
          ],
        ),
      ),
    );
  }
}

