import 'dart:async';
import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:gb_shopping_list/services/auth.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final AuthService _auth = AuthService();

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      await _auth.instance.currentUser?.reload();
      final user = _auth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Navigator.pushNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: <Widget>[
            Container(
                width: 250,
                height: 250,
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(25),
                child: Image.asset('assets/icon.png')),
            Container(
              padding: EdgeInsets.all(25),
              child: Text('Zweryfikuj adres e-mail!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
            ),
            Container(
              padding: EdgeInsets.all(25),
              child: Text('Sprawdź swoją skrzynkę pocztową',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
            ),
            Container(
              height: 75,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              child: ElevatedButton.icon(
                onPressed: () {
                  _auth.sendEmailVerification();
                },
                icon: Icon(
                  Icons.mark_email_read,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: Center(
                  child: Text('Wyślij ponownie e-mail weryfikacyjny',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
                ),
              ),
            ),
            Container(
              height: 75,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              child: ElevatedButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.pushNamed(context, '/');
                },
                icon: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: Center(
                  child: Text('Wyloguj się',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
