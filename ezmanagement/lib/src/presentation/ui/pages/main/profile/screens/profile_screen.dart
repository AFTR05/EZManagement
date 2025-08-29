import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/profile_header.dart';
import 'package:ezmanagement/src/presentation/ui/pages/main/profile/widgets/profile_menu.dart';
import 'package:ezmanagement/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final titleColor = isDark ? EZColorsApp.ezAppColor : EZColorsApp.blueOcean;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          LocaleKeys.profileTitle.tr(),
          style: TextStyle(
            fontFamily: 'OpenSansHebrew',
            color: titleColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          ProfileHeader(textColor: textColor),
          ProfileMenu(textColor: textColor, iconColor: EZColorsApp.blueOcean),
        ],
      ),
    );
  }
}
