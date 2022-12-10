import 'package:flutter/material.dart';

import 'gbslHomePage.dart';

import 'palette.dart';

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
            primary: GbPalette.GbYellow,
            secondary: GbPalette.GbYellow,
            tertiary: Colors.white),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
            primary: GbPalette.GbYellow,
            secondary: GbPalette.GbYellow,
            tertiary: Colors.black),
      ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const GBSLHomePage(),
    );
  }
}
