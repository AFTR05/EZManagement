import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/form/custom_form_element.dart';
import 'package:flutter/material.dart';

class CustomTextAreaFieldWidget extends StatelessWidget {
  const CustomTextAreaFieldWidget({
    super.key,
    required TextEditingController controller,
    required this.labelTitle,
    required this.hintText,
    this.maxLines = 4,
    this.minLines = 3,
    this.maxLength,
    this.enabled = true,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelTitle;
  final String hintText;
  final int maxLines;
  final int minLines;
  final int? maxLength;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CustomFormElement(
      widget: TextField(
        controller: _controller,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        enabled: enabled,
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: EZColorsApp.hoverColorText,
            fontSize: 14,
            fontFamily: "OpenSansHebrew",
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // Opcional: agregar un contador de caracteres si se especifica maxLength
          counterStyle: TextStyle(
            color: EZColorsApp.hoverColorText,
            fontSize: 12,
            fontFamily: "OpenSansHebrew",
          ),
        ),
        style: TextStyle(
          fontSize: 14,
          fontFamily: "OpenSansHebrew",
          height: 1.4,
        ),
      ),
      labelTitle: labelTitle,
    );
  }
}