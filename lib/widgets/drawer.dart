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
    final AuthService _auth = AuthService();
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
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Zalogowano jako:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
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
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('Moje listy'),
            onTap: () {
              Navigator.pushNamed(context, '/home');
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ustawienia konta'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              }
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('O aplikacji'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              }
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Wyloguj się'),
            onTap: () async {
              await _auth.signOut();
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}
