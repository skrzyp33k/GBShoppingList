import 'package:flutter/material.dart';

import 'package:gb_shopping_list/pages/start.dart';
import 'package:gb_shopping_list/pages/login.dart';
import 'package:gb_shopping_list/pages/register.dart';
import 'package:gb_shopping_list/pages/home.dart';

import 'props/palette.dart';

void main() {
  runApp(const GBSLApp());
}

class GBSLApp extends StatelessWidget {
  const GBSLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GB Shopping List',
      theme: ThemeData(
        colorScheme: const ColorScheme.light().copyWith(
          primary: GbPalette.yellow,
          secondary: GbPalette.yellow,
          tertiary: Colors.white,
          background: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
          primary: GbPalette.yellow,
          secondary: GbPalette.yellow,
          tertiary: Colors.black,
          background: Colors.black,
        ),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const RegisterPage(),
    );
  }
}
