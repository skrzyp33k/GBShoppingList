import 'package:flutter/material.dart';
import 'package:gb_shopping_list/widgets/item_card.dart';

class ListInfoPage extends StatefulWidget {
  const ListInfoPage({Key? key, required this.listName, required this.items})
      : super(key: key);

  final String listName;

  final List<ItemCard> items;

  @override
  State<ListInfoPage> createState() => _ListInfoPageState();
}

class _ListInfoPageState extends State<ListInfoPage> {
  @override
  Widget build(BuildContext context) {
    String listName = widget.listName;

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              //rawItems = //TODO: pobieranie listy
            });
          });
        },
        child: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(child: widget.items[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
