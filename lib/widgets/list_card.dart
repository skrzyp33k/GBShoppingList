import 'package:flutter/material.dart';
import 'package:gb_shopping_list/pages/home/list_info.dart';
import 'package:gb_shopping_list/widgets/item_card.dart';

class ListCard extends StatefulWidget {
  const ListCard(
      {Key? key,
      required this.listName,
      required this.checkedItems,
      required this.allItems,
      required this.inTrash})
      : super(key: key);

  final String listName;

  final int checkedItems;

  final int allItems;

  final bool inTrash;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    String listSize = "${widget.checkedItems} / ${widget.allItems}";
    String listName = widget.listName;
    bool inTrash = widget.inTrash;
    return InkWell(
      onTap: () => inTrash
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListInfoPage(listName: listName, items:[ItemCard(itemName: 'GB1', itemCount:'50kg', isChecked: true), ItemCard(itemName: 'GB2', itemCount: '3szt', isChecked: false)]))),
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                listName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            )),
            widget.inTrash
                ? Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          //TODO: przywróć
                        },
                        icon: const Icon(Icons.restore_from_trash),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      IconButton(
                        onPressed: () {
                          //TODO: usuń
                        },
                        icon: const Icon(Icons.delete_forever),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                    ],
                  )
                : Text(
                    listSize,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
