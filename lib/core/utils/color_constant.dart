import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color blueGray200 = fromHex('#bac1ce');

  static Color blueGray100 = fromHex('#d6dae2');

  static Color blueGray400 = fromHex('#74839d');

  static Color blue700 = fromHex('#1976d2');

  static Color black900 = fromHex('#000000');

  static Color blueA700 = fromHex('#0061ff');

  static Color gray900 = fromHex('#2a2a2a');

  static Color blueGray900 = fromHex('#262b35');

  static Color blueGray40001 = fromHex('#888888');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray50 = fromHex('#f9fbff');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
