import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    super.key,
    required TextEditingController controller, required this.labelTitle, required this.hintText,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelTitle;
  final String hintText;

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
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: EZColorsApp.hoverColorText, fontSize: 14, fontFamily: "OpenSansHebrew"),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}