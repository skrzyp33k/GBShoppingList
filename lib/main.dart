import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gb_shopping_list/models/user.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:gb_shopping_list/pages/wrapper.dart';

import 'package:gb_shopping_list/pages/auth/start.dart';
import 'package:gb_shopping_list/pages/auth/login.dart';
import 'package:gb_shopping_list/pages/auth/register.dart';
import 'package:gb_shopping_list/pages/home/home.dart';

import 'props/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GBSLApp());
}

class GBSLApp extends StatelessWidget {
  const GBSLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
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
          initialRoute: '/',
          routes:{
            '/': (context) => Wrapper(),
            '/start': (context) => StartPage(),
            '/login': (context) => LoginPage(),
            '/register': (context) => RegisterPage(),
            '/home': (context) => HomePage(),
          }
      ),
    );
  }
}
