
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class EZLogoWidget extends StatelessWidget {
  const EZLogoWidget({
    super.key,
    required this.width,
    required this.isSmallScreen,
    required this.isMediumScreen,
  });

  final double width;
  final bool isSmallScreen;
  final bool isMediumScreen;

  @override
  Widget build(BuildContext context) {
      double logoSize;
      if (isSmallScreen) {
        logoSize = 120;
      } else if (isMediumScreen) {
        logoSize = 150;
      } else {
        logoSize = 180;
      }

      return Container(
        padding: const EdgeInsets.all(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: SvgPicture.asset(
            'assets/images/ez_solutions_logo.svg',
            width: logoSize,
            height: logoSize,
            colorFilter: ColorFilter.mode(
              EZColorsApp.ezAppColor.withValues(alpha: .9),
              BlendMode.srcIn,
            ),
          ),
        ),
      );
    }
}