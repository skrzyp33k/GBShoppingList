import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gb_shopping_list/widgets/drawer.dart';
import 'package:move_to_background/move_to_background.dart';

class AppInfo extends StatefulWidget {
  const AppInfo({Key? key}) : super(key: key);

  @override
  State<AppInfo> createState() => _AppInfoState();
}

class _AppInfoState extends State<AppInfo> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('O aplikacji'),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
        ),
        drawer: const MenuDrawer(),
        body: Center(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              children: <Widget>[
                Container(
                    width: 250,
                    height: 250,
                    margin: const EdgeInsets.only(top: 50),
                    padding: const EdgeInsets.all(25),
                    child: Image.asset('assets/icon.png')),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Text('Twoja najlepsza lista zakupów!',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Text('Wersja: najlepsza',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                ),
                Container(
                  padding: const EdgeInsets.all(25),
                  child: Text('© 2022',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      )),
                ),
                Image.asset(
                  SchedulerBinding.instance.window.platformBrightness == Brightness.dark
                      ? 'assets/skrzyp33k_black.png'
                      : 'assets/skrzyp33k_white.png',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
