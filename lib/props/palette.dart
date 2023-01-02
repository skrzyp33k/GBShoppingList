//palette.dart
import 'package:flutter/material.dart';

class GbPalette {
  static const MaterialColor yellow = MaterialColor(
    0xffffbd59,
    // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe6aa50), //10%
      100: Color(0xffcc9747), //20%
      200: Color(0xffb3843e), //30%
      300: Color(0xff997135), //40%
      400: Color(0xff805f2d), //50%
      500: Color(0xff664c24), //60%
      600: Color(0xff4c391b), //70%
      700: Color(0xff332612), //80%
      800: Color(0xff191309), //90%
      900: Color(0xff000000), //100%
    },
  );
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below.
