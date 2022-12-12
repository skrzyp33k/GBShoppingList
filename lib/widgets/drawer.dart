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
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Zalogowano jako:',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text(user?.email ?? "",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                      )),
                ),
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        onPressed: () async {
                          await _auth.signOut();
                          Navigator.pushNamed(context, '/');
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings,
                          color: Theme.of(context).colorScheme.tertiary,
                        )),
                  ],
                )),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Messages'),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
