import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/models/list.dart';
import 'package:gb_shopping_list/widgets/list_card.dart';

import 'package:move_to_background/move_to_background.dart';

import 'package:gb_shopping_list/widgets/drawer.dart';

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
    TextEditingController listNameController = TextEditingController();

    final List<FloatingActionButton?> fabsList = <FloatingActionButton?>[
      FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Nazwa listy'),
              content: TextField(
                autofocus: true,
                controller: listNameController,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    listNameController.text = "";
                    Navigator.pop(context, "");
                  },
                  child: const Text('Anuluj'),
                ),
                TextButton(
                  onPressed: () {
                    String text = listNameController.text;
                    listNameController.text = "";
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
        child: const Icon(Icons.add),
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      null,
      FloatingActionButton(
          onPressed: () {
            showDialog<bool>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Opróżnianie kosza'),
                content: const Text('Jesteś pewien?'),
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
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          child: const Icon(Icons.delete_forever)),
    ];

    List<ListCard> rawItems = [
      ListCard(
          listModel:
              ListModel(listName: "W trakcie", isTrashed: false, listItems: [
        ItemModel(
            itemName: "element 1",
            itemCount: '5',
            itemUnit: 'szt',
            isChecked: true),
        ItemModel(
            itemName: "element 2",
            itemCount: '0.5',
            itemUnit: 'kg',
            isChecked: false),
      ])),
      ListCard(
          listModel:
              ListModel(listName: "Skonczona", isTrashed: false, listItems: [
        ItemModel(
            itemName: "element 1",
            itemCount: '2',
            itemUnit: 'szt',
            isChecked: true),
        ItemModel(
            itemName: "element 2",
            itemCount: '1.5',
            itemUnit: 'kg',
            isChecked: true),
      ])),
      ListCard(
          listModel:
              ListModel(listName: "W koszu", isTrashed: true, listItems: [
        ItemModel(
            itemName: "element 1",
            itemCount: '25',
            itemUnit: 'szt',
            isChecked: false),
        ItemModel(
            itemName: "element 2",
            itemCount: '14.5',
            itemUnit: 'l',
            isChecked: false),
      ])),
    ]; //TODO: we to pobierz z bazy co nie

    List<ListCard> activeLists = [];
    List<ListCard> finishedLists = [];
    List<ListCard> trashedLists = [];

    for (ListCard li in rawItems) {
      if (li.listModel.isTrashed) {
        trashedLists.add(li);
      } else {
        int checked = 0;
        for (ItemModel i in li.listModel.listItems) {
          if (i.isChecked) checked++;
        }
        if (checked >= li.listModel.listItems.length) {
          finishedLists.add(li);
        } else {
          activeLists.add(li);
        }
      }
    }

    final List<Widget> tabsList = <Widget>[
      RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              //rawItems = //TODO: pobieranie listy
            });
          });
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: activeLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(child: activeLists[index]);
          },
        ),
      ),
      RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              //rawItems = //TODO: pobieranie listy
            });
          });
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: finishedLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(child: finishedLists[index]);
          },
        ),
      ),
      RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              //rawItems = //TODO: pobieranie listy
            });
          });
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: trashedLists.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(child: trashedLists[index]);
          },
        ),
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_barTitle),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        drawer: const MenuDrawer(),
        body: Center(
          child: tabsList.elementAt(_selectedTab),
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
        floatingActionButton: fabsList.elementAt(_selectedTab),
      ),
    );
  }
}
