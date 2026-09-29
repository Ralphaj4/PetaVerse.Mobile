import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_submit_button.dart';

/// Change the signed-in user's password (JWT-authenticated, no OTP).
class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() =>
      _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (!form.saveAndValidate()) return;

    final notifier = ref.read(authProvider.notifier);
    final ok = await notifier.changePassword(
      oldPassword: form.value['currentPassword'] as String,
      newPassword: form.value['newPassword'] as String,
    );
    if (!mounted) return;
    if (ok) {
      context.showSnackBar(context.l10n.passwordChangedSuccess);
      context.pop();
    } else {
      final failure = notifier.lastFailure;
      if (failure != null) {
        context.showSnackBar(failure.localizedMessage(context.l10n));
      }
    }
  }

  Widget _passwordField({
    required String name,
    required String label,
    required bool obscure,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return FormBuilderTextField(
      name: name,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            obscure
                ? FluentIcons.eye_24_regular
                : FluentIcons.eye_off_24_regular,
            color: AppColors.textSecondary,
          ),
        ),
      ),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isLoading = ref.watch(authProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(l10n.changePassword),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.changePasswordSubtitle,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                _passwordField(
                  name: 'currentPassword',
                  label: l10n.currentPassword,
                  obscure: _obscureCurrent,
                  onToggle: () =>
                      setState(() => _obscureCurrent = !_obscureCurrent),
                  validator: FormBuilderValidators.required(
                    errorText: l10n.fieldRequired,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _passwordField(
                  name: 'newPassword',
                  label: l10n.newPassword,
                  obscure: _obscureNew,
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
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
                _passwordField(
                  name: 'confirmPassword',
                  label: l10n.confirmPassword,
                  obscure: _obscureConfirm,
                  onToggle: () =>
                      setState(() => _obscureConfirm = !_obscureConfirm),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return l10n.fieldRequired;
                    }
                    final newPass = _formKey
                        .currentState?.fields['newPassword']?.value as String?;
                    if (value != newPass) return l10n.passwordsDoNotMatch;
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.xxl),
                AuthSubmitButton(
                  label: l10n.changePassword,
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
