import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/entities/user.dart';
import '../providers/user_provider.dart';

class PersonalInformationPage extends ConsumerStatefulWidget {
  const PersonalInformationPage({super.key});

  @override
  ConsumerState<PersonalInformationPage> createState() =>
      _PersonalInformationPageState();
}

class _PersonalInformationPageState
    extends ConsumerState<PersonalInformationPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  DateTime? _selectedDateOfBirth;
  bool _isUpdating = false;
  User? _cachedUser;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _initializeForm(User user) {
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _emailController.text = user.email ?? '';
    _selectedDateOfBirth = user.dateOfBirth;
  }

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.saveAndValidate()) return;

    setState(() => _isUpdating = true);

    final notifier = ref.read(userProvider.notifier);
    await notifier.updateProfile(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailController.text.isEmpty ? null : _emailController.text,
      dateOfBirth: _selectedDateOfBirth,
    );

    if (!mounted) return;
    setState(() => _isUpdating = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userAsync = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          l10n.profile,
          style: AppTextStyles.titleLarge,
        ),
      ),
      body: userAsync.when(
        skipLoadingOnRefresh: true,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: $error'),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: () =>
                    ref.read(userProvider.notifier).refresh(),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (user) {
          _cachedUser = user;
          if (_firstNameController.text.isEmpty) {
            _initializeForm(user);
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          FormBuilderTextField(
                            name: 'firstName',
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: l10n.firstName,
                            ),
                            validator: FormBuilderValidators.required(
                              errorText: l10n.fieldRequired,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FormBuilderTextField(
                            name: 'lastName',
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: l10n.lastName,
                            ),
                            validator: FormBuilderValidators.required(
                              errorText: l10n.fieldRequired,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FormBuilderTextField(
                            name: 'email',
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: l10n.emailOptional,
                              helperText: user.pendingEmail != null
                                  ? 'Pending: ${user.pendingEmail}'
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return null;
                              }
                              return FormBuilderValidators.email(
                                errorText: l10n.invalidEmail,
                              )(value);
                            },
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          GestureDetector(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: _selectedDateOfBirth ??
                                    DateTime.now().subtract(
                                        const Duration(days: 365 * 18)),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (picked != null) {
                                setState(
                                    () => _selectedDateOfBirth = picked);
                              }
                            },
                            child: FormBuilderTextField(
                              name: 'dateOfBirth',
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: l10n.dateOfBirth,
                                hintText: _selectedDateOfBirth != null
                                    ? _selectedDateOfBirth
                                        .toString()
                                        .split(' ')[0]
                                    : 'Select date',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Container(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Account Information',
                            style: AppTextStyles.titleSmall,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Mobile Number',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: AppSpacing.sm),
                                    Text(
                                      user.mobileNumber,
                                      style: AppTextStyles.bodyMedium
                                          .copyWith(fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.md,
                                  vertical: AppSpacing.sm,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.md),
                                ),
                                child: Text(
                                  user.mobileVerified ? 'Verified' : 'Unverified',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: user.mobileVerified
                                        ? AppColors.primary
                                        : Colors.grey[500],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          Text(
                            'Member since ${user.createdAt.toString().split(' ')[0]}',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AppButton(
                      label: l10n.save,
                      onPressed: _isUpdating ? null : _submitUpdate,
                      isLoading: _isUpdating,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
