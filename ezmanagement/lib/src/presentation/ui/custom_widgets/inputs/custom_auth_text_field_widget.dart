import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAuthTextFieldWidget extends StatefulWidget {
  const CustomAuthTextFieldWidget({
    super.key,
    this.keyboardType,
    this.isTop = false,
    this.isBottom = false,
    this.isPasswordField = false,
    this.prefix,
    this.suffix,
    this.validator,
    this.pattern,
    this.boxBorder,
    required this.hintText,
    required this.controller,
  });

  final BoxBorder? boxBorder;
  final TextInputType? keyboardType;
  final bool isTop;
  final bool isBottom;
  final bool isPasswordField;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextInputFormatter? pattern;
  final String hintText;
  final TextEditingController controller;

  @override
  State<CustomAuthTextFieldWidget> createState() =>
      _CustomAuthTextFieldWidgetState();
}

class _CustomAuthTextFieldWidgetState extends State<CustomAuthTextFieldWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final borderRadius = widget.isTop
        ? const BorderRadius.only(topRight: Radius.circular(30))
        : widget.isBottom
        ? const BorderRadius.only(bottomRight: Radius.circular(30))
        : BorderRadius.zero;
    final borderColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : EZColorsApp.lightGray;
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        border: widget.boxBorder ?? Border(
          top: BorderSide(color: borderColor, width: 0.5),
          right: BorderSide(color: borderColor, width: 0.5),
          bottom: BorderSide(color: borderColor, width: 0.5),
          left: BorderSide(color: borderColor, width: 0.5),
        ),
      ),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.isPasswordField ? _obscurePassword : false,
        inputFormatters: widget.pattern != null ? [widget.pattern!] : null,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: EZColorsApp.hoverColorText, fontSize: 16),
          prefixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.lock_outline
                        : Icons.lock_open_outlined,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                )
              : widget.prefix,
          suffixIcon: widget.suffix,
          suffixIconConstraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 20,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
