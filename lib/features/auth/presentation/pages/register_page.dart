import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart' as flutter_markdown;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/countries.dart' as phone_countries;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/app/router/app_router.dart';
import '../../../../core/errors/failure_l10n.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/captcha_challenge.dart';
import '../../../../shared/widgets/location_field.dart';
import '../../../legal/domain/entities/legal.dart';
import '../../../legal/presentation/providers/legal_providers.dart';
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
  bool _legalAccepted = false;
  bool _legalTouched = false;

  // Set from the map pin. Required - validated alongside the form on submit.
  LatLng? _location;
  bool _locationTouched = false;

  void _openDocument(LegalDocumentType type) {
    final current = ref.read(legalCurrentProvider).value;
    final doc = current?.forType(type);
    final version = doc?.version;
    if (version == null || version.isEmpty) {
      context.showErrorSnackBar(context.l10n.legalDocumentUnavailable);
      return;
    }
    final title = switch (type) {
      LegalDocumentType.privacyPolicy => context.l10n.legalPrivacyPolicy,
      LegalDocumentType.termsAndConditions =>
        context.l10n.legalTermsAndConditions,
      _ => context.l10n.legalDocument,
    };
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (_) => _LegalSheetWrapper(
        type: type,
        version: version,
        title: title,
      ),
    );
  }

  Future<void> _submit({bool captchaAcknowledged = false}) async {
    setState(() {
      _locationTouched = true;
      _legalTouched = true;
    });
    final form = _formKey.currentState!;
    final formOk = form.saveAndValidate();
    final location = _location;
    if (!formOk || location == null || !_legalAccepted) return;

    final notifier = ref.read(authProvider.notifier);
    final result = await notifier.register(
      firstName: form.value['firstName'] as String,
      lastName: form.value['lastName'] as String,
      email: form.value['email'] as String?,
      phone: _completePhone,
      password: form.value['password'] as String,
      latitude: location.latitude,
      longitude: location.longitude,
      locationName: (form.value['locationName'] as String).trim(),
      captchaAcknowledged: captchaAcknowledged,
    );
    if (!mounted) return;
    if (result.captchaRequired) {
      final passed = await showCaptchaChallenge(context);
      if (!mounted) return;
      if (passed) await _submit(captchaAcknowledged: true);
      return;
    }
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
              countries: phone_countries.countries.where((c) => c.code == 'LB').toList(),
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
            const SizedBox(height: AppSpacing.xl),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                l10n.locationName,
                style: AppTextStyles.titleSmall,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            LocationField(
              addressFieldName: 'locationName',
              showValidationError: _locationTouched,
              onLocationChanged: (p) => setState(() => _location = p),
            ),
            const SizedBox(height: AppSpacing.xl),
            _LegalConsentCheckbox(
              accepted: _legalAccepted,
              showError: _legalTouched && !_legalAccepted,
              onChanged: (v) => setState(() => _legalAccepted = v),
              onOpenPrivacy: () => _openDocument(
                LegalDocumentType.privacyPolicy,
              ),
              onOpenTerms: () => _openDocument(
                LegalDocumentType.termsAndConditions,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
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

/// Checkbox row that asks the user to accept Privacy Policy and Terms & Conditions.
/// Each document name is tappable and opens the full document in-app.
class _LegalConsentCheckbox extends StatelessWidget {
  const _LegalConsentCheckbox({
    required this.accepted,
    required this.showError,
    required this.onChanged,
    required this.onOpenPrivacy,
    required this.onOpenTerms,
  });

  final bool accepted;
  final bool showError;
  final ValueChanged<bool> onChanged;
  final VoidCallback onOpenPrivacy;
  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final errorColor = Theme.of(context).colorScheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => onChanged(!accepted),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Checkbox(
                  value: accepted,
                  onChanged: (v) => onChanged(v ?? false),
                  activeColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: showError ? errorColor : AppColors.textTertiary,
                    width: 1.5,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _ConsentText(
                  l10n: l10n,
                  onOpenPrivacy: onOpenPrivacy,
                  onOpenTerms: onOpenTerms,
                ),
              ),
            ],
          ),
        ),
        if (showError) ...[
          const SizedBox(height: AppSpacing.xs),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 32),
            child: Text(
              l10n.legalConsentRequired,
              style: AppTextStyles.bodySmall.copyWith(color: errorColor),
            ),
          ),
        ],
      ],
    );
  }
}

/// The rich-text consent line. "Privacy Policy" and "Terms & Conditions" are
/// inline tappable spans that open the respective documents.
class _ConsentText extends StatelessWidget {
  const _ConsentText({
    required this.l10n,
    required this.onOpenPrivacy,
    required this.onOpenTerms,
  });

  final AppLocalizations l10n;
  final VoidCallback onOpenPrivacy;
  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    // Construct the rich text from three l10n parts so it's fully translatable.
    return Text.rich(
      TextSpan(
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        children: [
          TextSpan(text: l10n.legalConsentPrefix),
          WidgetSpan(
            child: GestureDetector(
              onTap: onOpenPrivacy,
              child: Text(
                l10n.legalPrivacyPolicy,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
          TextSpan(text: l10n.legalConsentAnd),
          WidgetSpan(
            child: GestureDetector(
              onTap: onOpenTerms,
              child: Text(
                l10n.legalTermsAndConditions,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.primary,
                ),
              ),
            ),
          ),
          TextSpan(text: l10n.legalConsentSuffix),
        ],
      ),
    );
  }
}

/// A thin wrapper that re-uses [_LegalContentSheet] logic without depending on
/// [LegalAcceptancePage]'s private class. Wraps a simple content sheet for use
/// from the register page where there is no full gate context.
class _LegalSheetWrapper extends ConsumerWidget {
  const _LegalSheetWrapper({
    required this.type,
    required this.version,
    required this.title,
  });

  final LegalDocumentType type;
  final String version;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final contentAsync = ref.watch(legalContentProvider(type, version));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.92,
      minChildSize: 0.5,
      maxChildSize: 0.92,
      builder: (context, scrollController) => Column(
        children: [
          const SizedBox(height: AppSpacing.sm),
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(child: Text(title, style: AppTextStyles.titleLarge)),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: l10n.close,
                  icon: const Icon(
                    FluentIcons.dismiss_24_regular,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          Expanded(
            child: contentAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FluentIcons.document_error_24_regular,
                        size: 48,
                        color: AppColors.textTertiary,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      Text(
                        l10n.legalDocumentUnavailable,
                        style: AppTextStyles.bodyMedium
                            .copyWith(color: AppColors.textSecondary),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(l10n.close),
                      ),
                    ],
                  ),
                ),
              ),
              data: (content) => flutter_markdown.Markdown(
                controller: scrollController,
                data: content.body,
                padding: const EdgeInsets.all(AppSpacing.lg),
                styleSheet: flutter_markdown.MarkdownStyleSheet(
                  p: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  h1: AppTextStyles.headlineMedium,
                  h2: AppTextStyles.titleLarge,
                  h3: AppTextStyles.titleMedium,
                  listBullet: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.textSecondary),
                  a: AppTextStyles.bodyMedium
                      .copyWith(color: AppColors.secondary),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
