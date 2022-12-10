import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Text('Witaj w GB Shopping List',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                )),
          ),
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: ElevatedButton.icon(
              onPressed: () => {},
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
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: ElevatedButton.icon(
              onPressed: () => {},
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
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.facebook,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4267B2),
                minimumSize: const Size.fromHeight(50),
              ),
              label: Center(
                child: Text('Zaloguj za pomocą Facebook',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
              ),
            ),
          ),
          Container(
            height: 50,
            margin:
                const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
            child: ElevatedButton.icon(
              icon: SizedBox(
                height: 30,
                child: FittedBox(
                  child: Text(
                  'G',
                  style: TextStyle(
                    fontFamily: 'ProductSans',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
                ),
              ),
              onPressed: () => {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDB4437),
                minimumSize: const Size.fromHeight(50),
              ),
              label: Center(
                child: Text('Zaloguj za pomocą Google',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
