import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_text_styles.dart';

/// Animated OTP input: a row of boxes backed by a single invisible
/// text field. Digits pop in with an elastic scale, the active box
/// glows, and borders animate as the code fills.
class OtpInput extends StatefulWidget {
  const OtpInput({
    required this.length,
    required this.onChanged,
    this.onCompleted,
    super.key,
  });

  final int length;
  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpInput> createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _value = '';

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    setState(() => _value = value);
    widget.onChanged(value);
    if (value.length == widget.length) widget.onCompleted?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    // Digits always render left-to-right, even in RTL locales.
    return Directionality(
      textDirection: TextDirection.ltr,
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Fit all boxes in the available width with equal horizontal gaps.
          // Cap at 64 so 4-digit boxes don't grow huge on tablets.
          const double maxBoxSize = 64;
          const double minGap = 6;
          final totalGap = minGap * 2 * widget.length;
          final boxSize =
              ((constraints.maxWidth - totalGap) / widget.length)
                  .clamp(0.0, maxBoxSize);

          return Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < widget.length; i++)
                    _OtpBox(
                      char: i < _value.length ? _value[i] : '',
                      isFilled: i < _value.length,
                      isActive: _focusNode.hasFocus &&
                          i == _value.length &&
                          _value.length < widget.length,
                      size: boxSize,
                      gap: minGap,
                    ),
                ],
              ),
              // Invisible field on top: tapping anywhere on the boxes
              // focuses it and brings up the number pad.
              Positioned.fill(
                child: Opacity(
                  opacity: 0,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(widget.length),
                    ],
                    showCursor: false,
                    enableInteractiveSelection: false,
                    decoration:
                        const InputDecoration(border: InputBorder.none),
                    onChanged: _handleChanged,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.char,
    required this.isFilled,
    required this.isActive,
    required this.size,
    required this.gap,
  });

  final String char;
  final bool isFilled;
  final bool isActive;
  final double size;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      width: size,
      height: size,
      margin: EdgeInsets.symmetric(horizontal: gap),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.smAll,
        border: Border.all(
          color: isFilled || isActive ? AppColors.primary : AppColors.divider,
          width: isActive ? 2 : 1.5,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  blurRadius: 12,
                ),
              ]
            : const [],
      ),
      child: Center(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.elasticOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Text(
            char,
            key: ValueKey<String>(char),
            style: AppTextStyles.headlineMedium,
          ),
        ),
      ),
    );
  }
}
