import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/form/custom_form_element.dart';
import 'package:flutter/material.dart';

class CustomInputTextFieldWidget extends StatefulWidget {
  const CustomInputTextFieldWidget({
    super.key,
    required TextEditingController controller,
    required this.labelTitle,
    required this.hintText,
    this.isPassword = false,
    this.textInputType = TextInputType.text,
  }) : _controller = controller;

  final TextEditingController _controller;
  final String labelTitle;
  final String hintText;
  /// Si es true, aparece el ojo y el texto inicia oculto
  final bool isPassword;
  final TextInputType? textInputType;

  @override
  State<CustomInputTextFieldWidget> createState() =>
      _CustomInputTextFieldWidgetState();
}

class _CustomInputTextFieldWidgetState extends State<CustomInputTextFieldWidget> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    // Si es password, empieza oculto; si no, visible
    _obscure = widget.isPassword;
  }

  @override
  void didUpdateWidget(covariant CustomInputTextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si desde afuera cambian isPassword, sincroniza el estado
    if (oldWidget.isPassword != widget.isPassword) {
      _obscure = widget.isPassword;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : EZColorsApp.darkColorText;

    return CustomFormElement(
      labelTitle: widget.labelTitle,
      widget: TextField(
        controller: widget._controller,
        keyboardType: widget.textInputType,
        obscureText: widget.isPassword ? _obscure : false,
        style: const TextStyle(
          fontFamily: "OpenSansHebrew",
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: EZColorsApp.hoverColorText,
            fontSize: 14,
            fontFamily: "OpenSansHebrew",
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          suffixIcon: widget.isPassword
              ? IconButton(
                  tooltip: _obscure ? 'Mostrar' : 'Ocultar',
                  onPressed: () => setState(() => _obscure = !_obscure),
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: iconColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
