import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  static Color whiteA700B2 = fromHex('#b2ffffff');
  static Color blue38B6FF = fromHex('#0dcaf0');
  static Color gray5001 = fromHex('#fff6f6');

  static Color blueGray10066 = fromHex('#66d6d6d6');

  static Color pink900 = fromHex('#8b192e');

  static Color red200 = fromHex('#e9a798');

  static Color rednew = fromHex('#EC8E7A');

  static Color red2003f = fromHex('#3fdf9283');

  static Color gray700A0 = fromHex('#a0686261');

  static Color red400 = fromHex('#eb5f41');

  static Color black9003f = fromHex('#3f000000');

  static Color green500 = fromHex('#43ad6d');

  static Color gray30099 = fromHex('#99e0e0e0');

  static Color black90001 = fromHex('#090909');

  static Color deepOrange20001 = fromHex('#ffa592');

  static Color deepOrange20002 = fromHex('#f8b2a3');

  static Color gray40059 = fromHex('#59c6c5c5');

  static Color lightBlueA700 = fromHex('#0092ec');

  static Color blueGray900 = fromHex('#343434');

  static Color gray600 = fromHex('#808080');

  static Color gray60066 = fromHex('#66818181');

  static Color gray400 = fromHex('#c6c4c4');

  static Color gray90026 = fromHex('#261b1b1b');

  static Color blueGray100 = fromHex('#cecece');

  static Color blueGray10033 = fromHex('#33d6d6d6');

  static Color whiteA7000a = fromHex('#0affffff');

  static Color red30066 = fromHex('#66e1826d');

  static Color gray800 = fromHex('#4f4f4f');

  static Color gray200 = fromHex('#eeeeee');

  static Color gray40001 = fromHex('#aeaeae');

  static Color bluegray400 = fromHex('#888888');

  static Color gray400A001 = fromHex('#a0bbb8b8');

  static Color whiteA7009d = fromHex('#9dffffff');

  static Color whiteA701 = fromHex('#ffffff');

  static Color whiteA700 = fromHex('#fffefe');

  static Color gray70001 = fromHex('#636262');

  static Color gray5007f = fromHex('#7fa3a3a3');

  static Color gray5003f = fromHex('#3facacac');

  static Color gray400A0 = fromHex('#a0b8b5b5');

  static Color red500 = fromHex('#e85839');

  static Color red40001 = fromHex('#e95a3b');

  static Color gray50 = fromHex('#fafafa');

  static Color black900 = fromHex('#000000');

  static Color gray50001 = fromHex('#9ba49d');

  static Color blueGray1001901 = fromHex('#19d5d5d5');

  static Color gray50003 = fromHex('#99a29b');

  static Color deepOrange200 = fromHex('#ffa693');

  static Color gray50002 = fromHex('#969e98');

  static Color gray40033 = fromHex('#33c0c0c0');

  static Color whiteA700A0 = fromHex('#a0ffffff');

  static Color gray700 = fromHex('#636363');

  static Color gray500 = fromHex('#9aa39d');

  static Color blueGray400 = fromHex('#878e89');

  static Color gray300 = fromHex('#dedede');

  static Color blueGray10019 = fromHex('#19d6d6d6');

  static Color gray600B2 = fromHex('#b2808080');

  static Color gray818181 = const Color(0xB3818181); // fromHex('#818181');

  static Color black90033 = fromHex('#33000000');

  static Color red300A0 = fromHex('#a0e1826e');

  static Color redE1826E = const Color(0xA1E1826E); // fromHex('#E1826E');

  static Color whiteA70001 = fromHex('#ffffff');

  static Color blueGray9003f = fromHex('#3f363535');

  static Color gray50033 = fromHex('#33acacac');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
