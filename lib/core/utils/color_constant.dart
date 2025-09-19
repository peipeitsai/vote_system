import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color gray400B7 = fromHex('#b7c8c4b7');

  static Color gray400 = fromHex('#d0ccc2');

  static Color gray500 = fromHex('#9e9684');

  static Color black900 = fromHex('#000000');

  static Color gray200 = fromHex('#f0f0f0');

  static Color bluegray400 = fromHex('#888888');

  static Color orange300 = fromHex('#f1be42');

  static Color blueA200 = fromHex('#5185ec');

  static Color gray401 = fromHex('#bdbdbd');

  static Color gray900 = fromHex('#241c1c');

  static Color red400 = fromHex('#d85140');

  static Color black9003f = fromHex('#3f000000');

  static Color green700 = fromHex('#2ca02c');

  static Color gray300 = fromHex('#e5e3dd');

  static Color whiteA700 = fromHex('#ffffff');

  static Color gray100 = fromHex('#f5f4f2');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
