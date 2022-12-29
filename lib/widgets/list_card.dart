import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/models/list.dart';
import 'package:gb_shopping_list/pages/home/list_info.dart';

class ListCard extends StatefulWidget {
  ListCard({
    Key? key,
    required this.listModel,
  }) : super(key: key);

  ListModel listModel;

  int checkedItems = 0;
  int allItems = 0;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  @override
  Widget build(BuildContext context) {
    ListModel list = widget.listModel;

    widget.allItems = list.listItems.length;

    for (ItemModel i in list.listItems) {
      if (i.isChecked) widget.checkedItems++;
    }

    String listSize = "${widget.checkedItems} / ${widget.allItems}";
    String listName = list.listName;
    bool isTrashed = list.isTrashed;
    return InkWell(
      onTap: () => isTrashed
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ListInfoPage(listName: listName, items: list.listItems))),
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
            widget.listModel.isTrashed
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
