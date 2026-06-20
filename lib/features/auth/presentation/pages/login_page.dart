import 'dart:async';

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
import '../../../../core/theme/app_text_styles.dart';
import '../../../pets/presentation/providers/pets_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/auth_layout.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_switch_link.dart';
import 'otp_verification_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String _completePhone = '';
  bool _obscurePassword = true;

  Future<void> _submit() async {
    final form = _formKey.currentState!;
    if (!form.saveAndValidate()) return;

    final notifier = ref.read(authProvider.notifier);
    final outcome = await notifier.login(
      phone: _completePhone,
      password: form.value['password'] as String,
    );
    if (!mounted) return;
    switch (outcome.result) {
      case LoginResult.authenticated:
        // Resolve the pet gate BEFORE navigating so we land on the right
        // screen directly — no home/splash flash. The spinner stays up during
        // this short fetch. Destination: home / pet-onboarding / select-pet.
        await ref.read(petsProvider.notifier).reconcile();
        if (!mounted) return;
        context.go(petLandingFor(ref.read(petsProvider)));
      case LoginResult.needsVerification:
        // Account exists but the phone isn't confirmed — the backend
        // resent an OTP, so continue to verification.
        unawaited(context.push(
          AppRoutes.otp,
          extra: OtpArgs(phone: _completePhone, devOtp: outcome.devOtp),
        ));
      case LoginResult.failed:
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
      titleTop: l10n.loginTitle1,
      titleAccent: l10n.loginTitle2,
      subtitle: l10n.loginSubtitle,
      child: FormBuilder(
        key: _formKey,
        child: Column(
          children: [
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
            const SizedBox(height: AppSpacing.sm),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () => context.push(AppRoutes.forgotPassword),
                child: Text(
                  l10n.forgotPassword,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthSubmitButton(
              label: l10n.logIn,
              isLoading: isLoading,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSwitchLink(
              prompt: l10n.noAccountPrompt,
              action: l10n.joinTheFamily,
              onTap: () => context.push(AppRoutes.register),
            ),
          ],
        ),
      ),
    );
  }
}
