import 'dart:ui';

import 'package:ezmanagement/environment_config.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}


class EZColorsApp {
  static final ezAppColor = HexColor.fromHex(EnvironmentConfig.hexColor);
  static final ezAppColorInverse =
      HexColor.fromHex(EnvironmentConfig.hexColorInverse);
  static const Color lightGray = Color(0xFFA6A1A1);
  static const Color blueOcean = Color(0xFF247BC3);


}