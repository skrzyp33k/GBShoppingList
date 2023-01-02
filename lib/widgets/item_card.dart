import 'package:flutter/material.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/pages/home/item_info.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  late bool isChecked;

  @protected
  @mustCallSuper
  void initState() {
    isChecked = widget.itemModel.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    String itemName = widget.itemModel.itemName;
    String itemCount = widget.itemModel.itemCount;
    String itemUnit = widget.itemModel.itemUnit;

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemInfoPage(itemModel: widget.itemModel))),
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
                child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      itemName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2.5, vertical: 10),
                  child: Text(
                    itemCount,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2.5, vertical: 10),
                  child: Text(
                    itemUnit,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 14,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            )),
            Checkbox(
                value: isChecked,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                checkColor: Theme.of(context).colorScheme.background,
                fillColor: MaterialStateProperty.resolveWith(
                    (states) => Theme.of(context).colorScheme.tertiary),
                onChanged: (val) {
                  setState(() {
                    isChecked = val!;
                  });
                }),
          ],
        ),
      ),
    );
  }
}
