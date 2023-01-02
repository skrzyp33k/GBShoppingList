import 'package:flutter/material.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:gb_shopping_list/widgets/drawer.dart';
import 'package:move_to_background/move_to_background.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ustawienia konta'),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        drawer: const MenuDrawer(),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 75,
              margin: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 25, right: 25),
              child: ElevatedButton.icon(
                onPressed: () {
                  String email = auth.instance.currentUser!.email!;
                  auth.instance.sendPasswordResetEmail(email: email);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Wysłano e-mail na adres $email"),
                  ));
                },
                icon: Icon(
                  Icons.password_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                label: Center(
                  child: Text('Zresetuj hasło',
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
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Usuwanie konta!'),
                      content: const Text('Jesteś pewien?!'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Tak'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Nie'),
                        ),
                      ],
                    ),
                  ).then((val) {
                    if (val!) {
                      auth.deleteUser();
                      Navigator.pushNamed(context, '/');
                    }
                  });
                },
                icon: Icon(
                  Icons.person_remove,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.redAccent,
                ),
                label: Center(
                  child: Text('Usuń konto',
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
