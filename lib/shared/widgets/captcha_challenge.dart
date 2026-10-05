import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/context_extensions.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_radius.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_text_styles.dart';

/// Shows a modal CAPTCHA challenge and resolves to [true] if the user passes,
/// [false] if they cancel or close the sheet.
///
/// Usage:
/// ```dart
/// final passed = await showCaptchaChallenge(context);
/// if (passed) { /* re-submit with captchaAcknowledged: true */ }
/// ```
Future<bool> showCaptchaChallenge(BuildContext context) async {
  final result = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _CaptchaSheet(),
  );
  return result ?? false;
}

class _CaptchaSheet extends StatefulWidget {
  const _CaptchaSheet();

  @override
  State<_CaptchaSheet> createState() => _CaptchaSheetState();
}

class _CaptchaSheetState extends State<_CaptchaSheet> {
  late _MathChallenge _challenge;
  int? _selectedIndex;
  bool _wrong = false;

  @override
  void initState() {
    super.initState();
    _challenge = _MathChallenge.generate();
  }

  void _onTap(int index) {
    if (_selectedIndex != null) return;
    setState(() => _selectedIndex = index);

    if (index == _challenge.correctIndex) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) Navigator.of(context).pop(true);
      });
    } else {
      setState(() => _wrong = true);
      Future.delayed(const Duration(milliseconds: 600), () {
        if (!mounted) return;
        setState(() {
          _challenge = _MathChallenge.generate();
          _selectedIndex = null;
          _wrong = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      padding: EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.xl + MediaQuery.paddingOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: AppRadius.smAll,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          // shield icon
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.primarySoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              FluentIcons.shield_checkmark_24_regular,
              size: 28,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.captchaTitle,
            style: AppTextStyles.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.captchaSubtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          // Math question
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.lg,
              horizontal: AppSpacing.xl,
            ),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: AppRadius.mdAll,
              border: Border.all(color: AppColors.divider),
            ),
            child: Text(
              _challenge.question,
              style: AppTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_wrong) ...[
            Text(
              l10n.captchaWrong,
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
          // Answer grid (2x2)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 2.8,
            ),
            itemCount: _challenge.choices.length,
            itemBuilder: (context, i) {
              final chosen = _selectedIndex == i;
              final correct = i == _challenge.correctIndex;
              Color bg;
              Color border;
              Color textColor;
              if (!chosen) {
                bg = AppColors.surface;
                border = AppColors.divider;
                textColor = AppColors.textPrimary;
              } else if (correct) {
                bg = AppColors.success.withValues(alpha: 0.1);
                border = AppColors.success;
                textColor = AppColors.success;
              } else {
                bg = AppColors.error.withValues(alpha: 0.1);
                border = AppColors.error;
                textColor = AppColors.error;
              }
              return GestureDetector(
                onTap: () => _onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: AppRadius.smAll,
                    border: Border.all(color: border, width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${_challenge.choices[i]}',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: textColor,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              l10n.captchaCancel,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A simple arithmetic challenge with 4 answer choices.
class _MathChallenge {
  const _MathChallenge({
    required this.question,
    required this.choices,
    required this.correctIndex,
  });

  final String question;
  final List<int> choices;
  final int correctIndex;

  static _MathChallenge generate() {
    final rng = Random();
    // Pick operator: 0=add, 1=subtract, 2=multiply
    final op = rng.nextInt(3);
    late int a, b, answer;
    late String question;

    switch (op) {
      case 0:
        a = rng.nextInt(20) + 1;
        b = rng.nextInt(20) + 1;
        answer = a + b;
        question = '$a + $b = ?';
      case 1:
        a = rng.nextInt(20) + 10;
        b = rng.nextInt(a) + 1;
        answer = a - b;
        question = '$a - $b = ?';
      default:
        a = rng.nextInt(9) + 2;
        b = rng.nextInt(9) + 2;
        answer = a * b;
        question = '$a × $b = ?';
    }

    // Build 4 distinct choices including the correct answer.
    final choices = <int>{answer};
    while (choices.length < 4) {
      final offset = rng.nextInt(11) - 5;
      if (offset != 0) choices.add(answer + offset);
    }
    final shuffled = choices.toList()..shuffle(rng);
    return _MathChallenge(
      question: question,
      choices: shuffled,
      correctIndex: shuffled.indexOf(answer),
    );
  }
}
