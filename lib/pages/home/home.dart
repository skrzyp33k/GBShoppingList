import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/user.dart';
import 'package:gb_shopping_list/props/palette.dart';

import 'package:move_to_background/move_to_background.dart';

import 'package:gb_shopping_list/widgets/drawer.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTab = 0;
  String _barTitle = "Aktywne listy";

  void _onTabTapped(int index) {
    setState(() {
      _selectedTab = index;
      switch (index) {
        case 0:
          _barTitle = "Aktywne listy";
          break;
        case 1:
          _barTitle = "Ukończone listy";
          break;
        case 2:
          _barTitle = "Usunięte listy";
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _listNameController = new TextEditingController();

    final List<FloatingActionButton?> _fabsList = <FloatingActionButton?>[
      FloatingActionButton(
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Wprowadź nazwę listy'),
                content: TextField(
                  controller: _listNameController,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      _listNameController.text = "";
                      Navigator.pop(context, "");
                    },
                    child: const Text('Anuluj'),
                  ),
                  TextButton(
                    onPressed: () {
                      String text = _listNameController.text;
                      _listNameController.text = "";
                      Navigator.pop(context, text);
                    },
                    child: const Text('Dodaj'),
                  ),
                ],
              ),
            ).then((val) {
              String name = val!.trim();
              {
                if (name.isNotEmpty) {
                  //TODO: dodawanie listy
                }
              }
            });
          },
          child: Icon(Icons.add)),
      null,
      FloatingActionButton(
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text('Opróżnianie kosza'),
                content: Text('Jesteś pewien?'),
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
                //TODO: usuwanie list
              }
            });
          },
          child: Icon(Icons.delete_forever)),
    ];

    final List<Widget> _tabsList = <Widget>[
      ListView(),
      ListView(),
      ListView(),
    ];

    final user = Provider.of<UserModel?>(context);

    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('$_barTitle'),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        drawer: MenuDrawer(),
        body: Center(
          child: _tabsList.elementAt(_selectedTab),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Aktywne listy'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline_rounded),
                label: 'Ukończone listy'),
            BottomNavigationBarItem(
                icon: Icon(Icons.delete_outline), label: 'Usunięte listy'),
          ],
          currentIndex: _selectedTab,
          onTap: _onTabTapped,
        ),
        floatingActionButton: _fabsList.elementAt(_selectedTab),
      ),
    );
  }
}
