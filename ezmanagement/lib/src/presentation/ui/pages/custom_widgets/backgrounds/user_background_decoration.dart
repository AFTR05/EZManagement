
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:flutter/widgets.dart';

class UserBackgroundDecorationWidget extends StatelessWidget {
  const UserBackgroundDecorationWidget({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -height * 0.18,
          left: -width * 0.25,
          child: ClipOval(
            child: Container(
              width: width * 0.45,
              height: height * 0.35,
              decoration: BoxDecoration(
                color: EZColorsApp.blueOcean,
                boxShadow: [
                  BoxShadow(
                    color: EZColorsApp.blueOcean.withValues(alpha: .3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: -height * 0.08,
          left: -width * 0.05,
          child: ClipOval(
            child: Container(
              width: width * 0.55,
              height: height * 0.18,
              decoration: BoxDecoration(
                color: EZColorsApp.ezAppColor,
                boxShadow: [
                  BoxShadow(
                    color: EZColorsApp.ezAppColor.withValues(alpha: .3),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Óvalos inferiores
        Positioned(
          bottom: -height * 0.18,
          right: -width * 0.25,
          child: ClipOval(
            child: Container(
              width: width * 0.45,
              height: height * 0.35,
              decoration: BoxDecoration(
                color: EZColorsApp.blueOcean,
                boxShadow: [
                  BoxShadow(
                    color: EZColorsApp.blueOcean.withValues(alpha: .3),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -height * 0.08,
          right: -width * 0.05,
          child: ClipOval(
            child: Container(
              width: width * 0.55,
              height: height * 0.18,
              decoration: BoxDecoration(
                color: EZColorsApp.ezAppColor,
                boxShadow: [
                  BoxShadow(
                    color: EZColorsApp.ezAppColor.withValues(alpha: .3),
                    blurRadius: 15,
                    spreadRadius: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
