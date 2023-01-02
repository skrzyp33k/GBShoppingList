import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/props/units.dart';
import 'package:gb_shopping_list/widgets/item_card.dart';
import 'package:provider/provider.dart';

class ListInfoPage extends StatefulWidget {
  ListInfoPage({Key? key, required this.listName, required this.items})
      : super(key: key);

  final String listName;

  late List<ItemModel> items;

  @override
  State<ListInfoPage> createState() => _ListInfoPageState();
}

class _ListInfoPageState extends State<ListInfoPage> {

  @override
  Widget build(BuildContext context) {
    String listName = widget.listName;

    String unit = Units().list.first;

    return Scaffold(
      appBar: AppBar(
        title: Text(listName),
        foregroundColor: Theme.of(context).colorScheme.tertiary,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(5),
          itemCount: widget.items.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(child: ItemCard(itemModel: widget.items[index]));
          },
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TextEditingController nameController =
          TextEditingController();
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Dodawanie produktu'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text("Nazwa:"),
                      Expanded(child: TextField()),
                    ],
                  ),
                  Row(
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
                          items: Units().list.map<DropdownMenuItem<String>>((String val) {
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
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    nameController.text = "";
                    Navigator.pop(context, "");
                  },
                  child: const Text('Anuluj'),
                ),
                TextButton(
                  onPressed: () {
                    String text = nameController.text;
                    nameController.text = "";
                    Navigator.pop(context, text);
                  },
                  child: const Text('Dodaj'),
                ),
              ],
            ),
          ).then((val) {
            String name = val!.trim();
            {
              if (name.isNotEmpty) {

              }
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
