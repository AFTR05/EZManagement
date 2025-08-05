import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomLoginButtonWidget extends StatelessWidget {
  const CustomLoginButtonWidget({
    super.key,
    required this.isSmallScreen,
    this.onTap,
  });

  final bool isSmallScreen;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final buttonSize = isSmallScreen ? 50.0 : 60.0;

    return Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: EZColorsApp.blueOcean,
      ),
      child: Material(
        child: InkWell(
          borderRadius: BorderRadius.circular(buttonSize / 2),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'assets/images/icons/arrow_forward_logo.svg',
              width: isSmallScreen ? 20 : 24,
              height: isSmallScreen ? 20 : 24,
              colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
