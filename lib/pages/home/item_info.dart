import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({Key? key, required this.itemName}) : super(key: key);

  final String itemName;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  List<String> units = <String>["szt", "kg", "l"];

  late String unit = units.first;

  @override
  Widget build(BuildContext context) {
    String itemName = widget.itemName;

    return WillPopScope(
      onWillPop: () async {
        return true;
      }, //TODO: dialog czy zapisać zmiany
      child: Scaffold(
        appBar: AppBar(
          title: Text(itemName),
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
                Expanded(child: TextField()),
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
