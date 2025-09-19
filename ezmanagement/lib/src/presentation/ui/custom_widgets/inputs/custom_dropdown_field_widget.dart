import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/form/custom_form_element.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  const CustomDropdownWidget({
    super.key,
    required this.labelTitle,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.enabled = true,
    this.itemBuilder,
    this.displayStringForItem,
    this.dropdownColor,
  });

  final String labelTitle;
  final String hintText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  final Widget Function(T item)? itemBuilder;
  final String Function(T item)? displayStringForItem;
  final Color? dropdownColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final iconColor = isDark ? Colors.white : EZColorsApp.darkColorText;
    final menuBg = dropdownColor ?? defaultColor;

    return CustomFormElement(
      widget: Theme(
        data: Theme.of(context).copyWith(
          hoverColor: EZColorsApp.ezAppColor.withValues(alpha: .1),
          focusColor: EZColorsApp.ezAppColor.withValues(alpha: .2),
          hintColor: EZColorsApp.hoverColorText,
          colorScheme: Theme.of(
            context,
          ).colorScheme.copyWith(primary: EZColorsApp.ezAppColor),
        ),
        child: DropdownButtonFormField<T>(
          value: value,
          onChanged: enabled ? onChanged : null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 14,
              fontFamily: "OpenSansHebrew",
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: Icon(Icons.keyboard_arrow_down, color: iconColor),
          ),
          style: TextStyle(
            color: iconColor,
            fontSize: 14,
            fontFamily: "OpenSansHebrew",
          ),
          dropdownColor: menuBg,
          icon: const SizedBox.shrink(),
          isExpanded: true,
          selectedItemBuilder: (BuildContext context) {
            return items.map<Widget>((T item) {
              return Text(
                displayStringForItem != null
                    ? displayStringForItem!(item)
                    : item.toString(),
                style: TextStyle(
                  color: iconColor,
                  fontSize: 14,
                  fontFamily: "OpenSansHebrew",
                ),
              );
            }).toList();
          },
          items: items.map<DropdownMenuItem<T>>((T item) {
            final isSelected = item == value;

            return DropdownMenuItem<T>(
              value: item,
              child: SizedBox(
                width: double.infinity,
                child: itemBuilder != null
                    ? itemBuilder!(item)
                    : Text(
                        displayStringForItem != null
                            ? displayStringForItem!(item)
                            : item.toString(),
                        style: TextStyle(
                          color: isSelected
                              ? EZColorsApp.ezAppColor
                              : EZColorsApp.hoverColorText,
                          fontSize: 14,
                          fontFamily: "OpenSansHebrew",
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
              ),
            );
          }).toList(),
        ),
      ),
      labelTitle: labelTitle,
    );
  }
}

// Widget específico para dropdowns con strings simples
class CustomStringDropdownWidget extends StatelessWidget {
  const CustomStringDropdownWidget({
    super.key,
    required this.labelTitle,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.enabled = true,
  });

  final String labelTitle;
  final String hintText;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget<String>(
      labelTitle: labelTitle,
      hintText: hintText,
      items: items,
      value: value,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}

// Widget específico para dropdowns con enums
class CustomEnumDropdownWidget<T extends Enum> extends StatelessWidget {
  const CustomEnumDropdownWidget({
    super.key,
    required this.labelTitle,
    required this.hintText,
    required this.enumValues,
    required this.onChanged,
    this.value,
    this.enabled = true,
    this.displayStringForEnum,
  });

  final String labelTitle;
  final String hintText;
  final List<T> enumValues;
  final T? value;
  final ValueChanged<T?> onChanged;
  final bool enabled;

  // Función para personalizar cómo se muestra cada enum
  final String Function(T enumValue)? displayStringForEnum;

  @override
  Widget build(BuildContext context) {
    return CustomDropdownWidget<T>(
      labelTitle: labelTitle,
      hintText: hintText,
      items: enumValues,
      value: value,
      onChanged: onChanged,
      enabled: enabled,
      displayStringForItem: displayStringForEnum ?? (item) => item.name,
    );
  }
}
