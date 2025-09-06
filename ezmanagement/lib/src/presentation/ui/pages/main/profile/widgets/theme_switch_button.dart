import 'package:ezmanagement/src/inject/app_states/theme_provider.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeSwitchButton extends ConsumerWidget {
  const ThemeSwitchButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeAppProvider);
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    final mainBlue = EZColorsApp.ezAppColor;
    final cardColor = isDarkmode ? EZColorsApp.darkGray : Colors.white;
    final shadowColor = isDarkmode
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.09);
    final textColor = isDarkmode ? Colors.white : Colors.black87;
    final inactiveTrackColor = isDarkmode
        ? EZColorsApp.grayColor.withValues(alpha: 0.69)
        : EZColorsApp.grayColor.withValues(alpha: 0.35);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        shadowColor: shadowColor,
        borderRadius: BorderRadius.circular(10),
        color: cardColor,
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: cardColor,
          leading: Icon(
            Icons.palette,
            color: mainBlue,
            size: 21,
          ),
          title: Text(
            "Tema Oscuro",
            style: TextStyle(
              fontFamily: 'OpenSansHebrew',
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: textColor,
            ),
          ),
          trailing: Switch(
            value: themeMode == ThemeMode.dark,
            activeColor: mainBlue,
            activeTrackColor: mainBlue.withValues(alpha: 0.25),
            inactiveThumbColor: isDarkmode ? EZColorsApp.lightGray : Colors.white,
            inactiveTrackColor: inactiveTrackColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashRadius: 0, 
            onChanged: (value) {
              ref.read(themeAppProvider.notifier).setTheme(
                value ? ThemeMode.dark : ThemeMode.light,
              );
            },
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ),
    );
  }
}
