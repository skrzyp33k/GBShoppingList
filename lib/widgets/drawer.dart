import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/user.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    final AuthService auth = AuthService();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    'Zalogowano jako:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: Text(user?.email ?? "",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                      )),
                ),
              ],
            ),
          ),
          ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Moje listy'),
              onTap: () {
                Navigator.pushNamed(context, '/home');
              }),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Ustawienia konta'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              }),
          ListTile(
              leading: const Icon(Icons.info),
              title: const Text('O aplikacji'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              }),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Wyloguj się'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
