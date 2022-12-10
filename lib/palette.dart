//palette.dart
import 'package:flutter/material.dart';
class GbPalette {
  static const MaterialColor GbYellow = const MaterialColor(
    0xffffbd59, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffe6aa50),//10%
      100: const Color(0xffcc9747),//20%
      200: const Color(0xffb3843e),//30%
      300: const Color(0xff997135),//40%
      400: const Color(0xff805f2d),//50%
      500: const Color(0xff664c24),//60%
      600: const Color(0xff4c391b),//70%
      700: const Color(0xff332612),//80%
      800: const Color(0xff191309),//90%
      900: const Color(0xff000000),//100%
    },
  );
} // you can define define int 500 as the default shade and add your lighter tints above and darker tints below.