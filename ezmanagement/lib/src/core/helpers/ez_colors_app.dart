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
  static const Color darkBackgroud = Color(0xFF1E1E1E);
  static const Color grayColor = Color(0xFF696969);
  static const Color greyColorIcon = Color.fromRGBO(112, 112, 112, 1);
  static const Color textDarkColor = Color.fromRGBO(36, 36, 37, 1);
  static const Color darkColorText = Color.fromRGBO(30, 30, 30, 1);
  static const Color darkGray = Color(0xFF242425);


}