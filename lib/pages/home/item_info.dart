import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/pages/home/list_info.dart';
import 'package:gb_shopping_list/props/units.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:gb_shopping_list/services/database.dart';

class ItemInfoPage extends StatefulWidget {
  ItemInfoPage({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  late ListInfoPage listInfoPage;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    ItemModel item = widget.itemModel;

    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    TextEditingController infoController = TextEditingController();

    nameController.text = item.itemName;
    countController.text = item.itemCount;
    infoController.text = item.itemInfo;

    String unit = item.itemUnit;

    List<String> units = Units().list;

    return WillPopScope(
      onWillPop: () async {
        showDialog<bool?>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Zapisać zmiany?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Nie'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text('Tak'),
              ),
            ],
          ),
        ).then((val) {
          {
            if (val!)
            {
              String newName = nameController.text;
              String newCount = countController.text;
              String newInfo = infoController.text;
              String newUnit = unit;
              ItemModel newItem = ItemModel(
                  itemName: newName,
                  itemCount: newCount,
                  itemUnit: newUnit,
                  itemInfo: newInfo,
                  isChecked: item.isChecked,
                  listID: item.listID);
              DatabaseService(uid: AuthService().uid)
                  .replaceItem(item, newItem);
              item = newItem;
            }
            Navigator.pop(context);
            return true;
          }
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(item.itemName),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: ()  {
                    showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Czy usunąć element z listy?'),
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
                          DatabaseService(uid: AuthService().uid).deleteItemFromList(widget.itemModel);
                          Navigator.pop(context);
                        }
                      }
                    });
                  },
                  child: Icon(Icons.delete),
                )),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                const Text("Nazwa:"),
                Expanded(
                    child: TextField(
                  controller: nameController,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Ilość:"),
                Expanded(
                    child: TextField(
                  controller: countController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      try {
                        final text = newValue.text;
                        if (text.isNotEmpty) double.parse(text);
                        return newValue;
                      } catch (e) {}
                      return oldValue;
                    }),
                  ],
                )),
                DropdownButton<String>(
                    value: unit,
                    items: units.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        unit = val!;
                      });
                    })
              ],
            ),
            const Text('Dodatkowe informacje:'),
            TextField(
              controller: infoController,
              keyboardType: TextInputType.multiline,
              minLines: 1, //Normal textInputField will be displayed
              maxLines: 5, // when user presses enter it will adapt to it
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Zrób zdjęcie'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Dodaj zdjęcie'),
                ),
              ],
            ),
            //Image(image: null,), //TODO: wyswietlanie obrazka
          ],
        ),
      ),
    );
  }
}
