import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                    width: 250,
                    height: 250,
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(25),
                    child: Image.asset('assets/icon.png')),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Text('Witamy ponownie!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      )),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  child: Container(
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      obscureText: false,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Adres e-mail',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 10, left: 25, right: 25),
                  child: Container(
                    child: TextFormField(
                      scrollPadding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Hasło',
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                      top: 10, bottom: 25, left: 25, right: 25),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    icon: Icon(
                      Icons.login,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    label: Center(
                      child: Text('Zaloguj się',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                          )),
                    ),
                  ),
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                        text: 'Powrót',
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.pop(context);
                        },
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
