import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/props/units.dart';
import 'package:provider/provider.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  @override
  Widget build(BuildContext context) {
    ItemModel item = widget.itemModel;

    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();

    nameController.text = item.itemName;
    countController.text = item.itemCount;

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
            if (val!) //TODO: zapisanie zmian
            {}
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
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text("Nazwa:"),
                Expanded(child: TextField(
                  controller: nameController,
                )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Ilość:"),
                Expanded(
                    child: Container(
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
                ))),
                DropdownButton<String>(
                    value: item.itemUnit,
                    items: units.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem<String>(
                        value: val,
                        child: Text(val),
                      );
                    }).toList(),
                    onChanged: (String? val) {
                      setState(() {
                        item.itemUnit = val!;
                      });
                    })
              ],
            ),
            Text('Dodatkowe informacje:'),
            TextField(
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
                  child: Text('Zrób zdjęcie'),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Dodaj zdjęcie'),
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
