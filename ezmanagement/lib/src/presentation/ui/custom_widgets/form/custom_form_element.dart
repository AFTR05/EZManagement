import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';

class CustomFormElement extends StatelessWidget {
  const CustomFormElement({
    super.key,
    required this.widget, required this.labelTitle,
  });

  final Widget widget;
  final String labelTitle;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textPrimary,
            fontFamily: "OpenSansHebrew"
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: EZColorsApp.ezAppColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget
        ),
      ],
    );
  }
}