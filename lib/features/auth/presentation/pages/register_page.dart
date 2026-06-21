import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_switch_link.dart';
import 'otp_verification_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String _completePhone = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (!form.saveAndValidate()) return;

    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.register(
      firstName: form.value['firstName'] as String,
      lastName: form.value['lastName'] as String,
      email: form.value['email'] as String?,
      phone: _completePhone,
      password: form.value['password'] as String,
    );
    if (!mounted) return;
    if (result.ok) {
      await context.push(
        AppRoutes.otp,
        extra: OtpArgs(
          phone: _completePhone,
          devOtp: result.devOtp,
          isRegister: true,
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

    return AuthLayout(
      showBack: true,
      titleTop: l10n.registerTitle1,
      titleAccent: l10n.registerTitle2,
      subtitle: l10n.registerSubtitle,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'firstName',
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: l10n.firstName),
                    validator: FormBuilderValidators.required(
                      errorText: l10n.fieldRequired,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'lastName',
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(labelText: l10n.lastName),
                    validator: FormBuilderValidators.required(
                      errorText: l10n.fieldRequired,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            IntlPhoneField(
              decoration: InputDecoration(labelText: l10n.mobileNumber),
              initialCountryCode: 'LB',
              languageCode: Localizations.localeOf(context).languageCode,
              invalidNumberMessage: l10n.invalidPhone,
              dropdownIcon: const Icon(
                FluentIcons.chevron_down_24_regular,
                size: 18,
                color: AppColors.textSecondary,
              ),
              onChanged: (phone) => _completePhone = phone.completeNumber,
            ),
            const SizedBox(height: AppSpacing.lg),
            FormBuilderTextField(
              name: 'email',
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: l10n.emailOptional),
              validator: (value) {
                if (value == null || value.trim().isEmpty) return null;
                return FormBuilderValidators.email(
                  errorText: l10n.invalidEmail,
                )(value);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            FormBuilderTextField(
              name: 'password',
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: l10n.password,
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? FluentIcons.eye_24_regular
                        : FluentIcons.eye_off_24_regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(errorText: l10n.fieldRequired),
                FormBuilderValidators.minLength(
                  8,
                  errorText: l10n.passwordTooShort,
                ),
              ]),
            ),
            const SizedBox(height: AppSpacing.lg),
            FormBuilderTextField(
              name: 'confirmPassword',
              obscureText: _obscureConfirmPassword,
              decoration: InputDecoration(
                labelText: l10n.confirmPassword,
                suffixIcon: IconButton(
                  onPressed: () => setState(
                    () => _obscureConfirmPassword = !_obscureConfirmPassword,
                  ),
                  icon: Icon(
                    _obscureConfirmPassword
                        ? FluentIcons.eye_24_regular
                        : FluentIcons.eye_off_24_regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.fieldRequired;
                }
                final password =
                    _formKey.currentState?.fields['password']?.value as String?;
                if (value != password) return l10n.passwordsDoNotMatch;
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
            AuthSubmitButton(
              label: l10n.signUp,
              isLoading: isLoading,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSwitchLink(
              prompt: l10n.haveAccountPrompt,
              action: l10n.logInLink,
              onTap: () => context.go(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}
