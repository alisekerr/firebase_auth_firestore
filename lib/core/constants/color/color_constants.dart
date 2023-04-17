import 'package:flutter/material.dart';

class ColorConstants {
  static Color transparentColor = Colors.transparent;
  // White variations
  static Color whiteColor = hexToColor('#FFFFFF');
  // Black variations
  static Color blackColor = hexToColor('#000000');
  static Color darkBlackColor = hexToColor('#0F172A');
  static Color semiBlackColor = hexToColor('#3A3A3C');
  static Color semiDarkBlackColor = hexToColor('#0A0A0A');
  // Gray variations
  static Color lightenGrayColor = hexToColor('#B5B5B5');
  static Color lightGrayColor = hexToColor('#0F172A');
  static Color mediumGrayColor = hexToColor('#D9D9D9');
  static Color semiGrayColor = hexToColor('#E0DDFF');
  static Color darkGrayColor = hexToColor('#4B5760');
  static Color tineGrayColor = hexToColor('#A1A1A1');
  // Blue variations
  static Color lightBlueColor = hexToColor('#CEF7FF');
  static Color lightSemiBlueColor = hexToColor('#3EC9ED');
  static Color darkSemiBlueColor = hexToColor('#0099F7');
  static Color darkBlueColor = hexToColor('#002469');
  // Red variations
  static Color lightRedColor = hexToColor('#EC0044');
  static Color darkRedColor = hexToColor('#C80036');
  // Orange variations
  static Color lightOrangeColor = hexToColor('#EC8800');
  static Color darkOrangeColor = hexToColor('#FFC107');
  // Green variations
  static Color lightGreenColor = hexToColor('#28A745');
  static Color darkGreenColor = hexToColor('#A4C845');
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}
