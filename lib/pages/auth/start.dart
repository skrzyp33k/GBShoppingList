import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
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
                margin: const EdgeInsets.only(top: 50),
                padding: const EdgeInsets.all(25),
                child: Image.asset('assets/icon.png')),
            Container(
              padding: const EdgeInsets.all(25),
              child: Text('Witaj w GB Shopping List',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  )),
            ),
            Container(
              height: 75,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                icon: Icon(
                  Icons.login,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: Center(
                  child: Text('Mam już konto, zaloguj się',
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
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                icon: Icon(
                  Icons.app_registration,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: Center(
                  child: Text('Nie mam konta, zarejestruj się',
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
