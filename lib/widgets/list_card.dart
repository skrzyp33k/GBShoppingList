import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/models/list.dart';
import 'package:gb_shopping_list/pages/home/list_info.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:gb_shopping_list/services/database.dart';

class ListCard extends StatefulWidget {
  const ListCard({
    Key? key,
    required this.listModel,
  }) : super(key: key);

  final ListModel listModel;

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  int checkedItems = 0;
  int allItems = 0;

  @override
  Widget build(BuildContext context) {
    ListModel list = widget.listModel;

    allItems = list.listItems.length;
    checkedItems = 0;

    for (ItemModel i in list.listItems) {
      if (i.isChecked) checkedItems++;
    }

    String listSize = "$checkedItems / $allItems";
    String listName = list.listName;
    bool isTrashed = list.isTrashed;
    return InkWell(
      onTap: () => isTrashed
          ? null
          : Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListInfoPage(
                      listName: listName,
                      items: list.listItems,
                      listID: list.ID))),
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
                          DatabaseService(uid: AuthService().uid)
                              .moveListFromTrash(widget.listModel.ID);
                        },
                        icon: const Icon(Icons.restore_from_trash),
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog<bool>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Czy usunąć listę na zawsze?'),
                              content: const Text('To jest bardzo długo!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Tak'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Nie'),
                                ),
                              ],
                            ),
                          ).then((val) {
                            {
                              if (val!) {
                                DatabaseService(uid: AuthService().uid)
                                    .deleteListFromTrash(widget.listModel.ID);
                              }
                            }
                          });
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
