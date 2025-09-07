import 'package:ezmanagement/src/inject/app_states/theme_provider.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDarkmode ? EZColorsApp.darkGray : Colors.white;
    final shadowColor = isDarkmode
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.09);
    final textColor = isDarkmode ? Colors.white : Colors.black87;

    // Icono dinámico basado en el tema actual
    final themeIcon = isDarkmode ? Icons.dark_mode : Icons.light_mode;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 15,
              offset: const Offset(1, 1),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Material(
          elevation: 2,
          shadowColor: shadowColor,
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            tileColor: cardColor,
            leading: Icon(themeIcon, color: EZColorsApp.ezAppColor, size: 22),
            title: Text(
              isDarkmode ? "Tema Oscuro" : "Tema Claro",
              style: TextStyle(
                fontFamily: 'OpenSansHebrew',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: textColor,
              ),
            ),
            trailing: Switch(
              value: isDarkmode,
              activeColor: Colors.white,
              activeTrackColor: EZColorsApp.ezAppColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: EZColorsApp.lightGray,
              trackOutlineColor: WidgetStateProperty.all(
                isDarkmode
                    ? EZColorsApp.ezAppColor
                    : EZColorsApp.lightGray,
              ),
              onChanged: (value) {
                ref
                    .read(themeAppProvider.notifier)
                    .setTheme(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 4,
            ),
          ),
        ),
      ),
    );
  }
}
