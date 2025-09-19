import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.actions = const []
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final brand = EZColorsApp.ezAppColor;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: scaffoldBg,
      centerTitle: true,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: SvgPicture.asset(
          'assets/images/icons/return_icon.svg',
          width: 28,
          height: 28,
        ),
      ),
      actions: actions,
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'OpenSansHebrew',
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: brand,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
