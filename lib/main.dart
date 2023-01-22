import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/list.dart';
import 'package:gb_shopping_list/models/user.dart';
import 'package:gb_shopping_list/pages/auth/login.dart';
import 'package:gb_shopping_list/pages/auth/register.dart';
import 'package:gb_shopping_list/pages/auth/start.dart';
import 'package:gb_shopping_list/pages/home/account_settings.dart';
import 'package:gb_shopping_list/pages/home/app_info.dart';
import 'package:gb_shopping_list/pages/home/home.dart';
import 'package:gb_shopping_list/pages/wrapper.dart';
import 'package:gb_shopping_list/props/palette.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:gb_shopping_list/services/database.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

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
    return MultiProvider(
        providers: [
          StreamProvider<UserModel?>(
              create: (_) => AuthService().user,
              lazy: false,
              initialData: null),
          StreamProvider<List<ListModel>>(
              create: (_) => DatabaseService(uid: AuthService().uid).lists,
              lazy: false,
              initialData: []),
        ],
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
