import 'package:flutter/material.dart';

import 'package:move_to_background/move_to_background.dart';

import 'package:gb_shopping_list/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('GB Shopping List'),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        drawer: MenuDrawer(),
        body: Text('siema'),
      ),
    );
  }
}
