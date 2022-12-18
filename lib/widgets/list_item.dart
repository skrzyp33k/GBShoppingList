
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {Key? key,
      required this.listName,
      required this.checkedItems,
      required this.allItems, required this.inTrash, this.onTap})
      : super(key: key);

  final String listName;

  final int checkedItems;

  final int allItems;

  final bool inTrash;

  final Function? onTap;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    String listSize =  "${widget.checkedItems} / ${widget.allItems}";
    String listName = widget.listName;
    return InkWell(
      onTap: () => widget.inTrash ? null : widget.onTap!(),
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
            widget.inTrash ? Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.restore_from_trash), color: Theme.of(context).colorScheme.tertiary,),
                IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever), color: Theme.of(context).colorScheme.tertiary,),
              ],
            ) : Column(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.edit), color: Theme.of(context).colorScheme.tertiary,),
                Text(
                  listSize,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
