import 'package:flutter/material.dart';

class ColorParserHelper {
  static Color colorFromString(
    String colorString,
  ) {
    return Color(
      int.parse(
        colorString.replaceFirst(
          '#',
          '0xff',
        ),
      ),
    );
  }
}
