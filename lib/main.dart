import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:gb_shopping_list/models/list.dart';
import 'package:gb_shopping_list/services/database.dart';
import 'firebase_options.dart';

import 'package:provider/provider.dart';

import 'package:gb_shopping_list/models/user.dart';

import 'package:gb_shopping_list/services/auth.dart';

import 'package:gb_shopping_list/pages/wrapper.dart';

import 'package:gb_shopping_list/pages/auth/start.dart';
import 'package:gb_shopping_list/pages/auth/login.dart';
import 'package:gb_shopping_list/pages/auth/register.dart';
import 'package:gb_shopping_list/pages/home/home.dart';
import 'package:gb_shopping_list/pages/home/account_settings.dart';
import 'package:gb_shopping_list/pages/home/app_info.dart';

import 'package:gb_shopping_list/props/palette.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GBSLApp());
}

class GBSLApp extends StatelessWidget {
  GBSLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          StreamProvider<UserModel?>.value(
              value: AuthService().user, initialData: null),
          StreamProvider<List<ListModel>>.value(
              value: DatabaseService(uid: AuthService().uid).lists, initialData: []
          ),
        ],
        child: MaterialApp(
            title: 'GB Shopping List',
            theme: ThemeData(
              colorScheme: const ColorScheme.light().copyWith(
                primary: GbPalette.yellow,
                secondary: GbPalette.yellow,
                tertiary: Colors.white,
                background: Colors.black,
              ),
            ),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: GbPalette.yellow,
                secondary: GbPalette.yellow,
                tertiary: Colors.black,
                background: Colors.white,
              ),
            ),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const Wrapper(),
              '/start': (context) => const StartPage(),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/home': (context) => const HomePage(),
              '/about': (context) => const AppInfo(),
              '/settings': (context) => const AccountSettings(),
            }));
  }
}
