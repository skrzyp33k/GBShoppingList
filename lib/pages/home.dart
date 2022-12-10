import 'package:flutter/material.dart';

import 'package:gb_shopping_list/widgets/drawer.dart';

class GBSLHomePage extends StatelessWidget {
  const GBSLHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('GB Shopping List'),
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: MenuDrawer(),
      body: Text('siema'),
    );
  }
}
