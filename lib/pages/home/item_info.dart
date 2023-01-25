import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/props/palette.dart';
import 'package:gb_shopping_list/props/units.dart';
import 'package:gb_shopping_list/services/auth.dart';
import 'package:gb_shopping_list/services/database.dart';
import 'package:barcode_widget/barcode_widget.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({Key? key, required this.itemModel}) : super(key: key);

  final ItemModel itemModel;

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  ItemModel? _oldItem;

  String _barcodeLastResult = "";

  String _barcode = "";

  _scan() async {
    var options = const ScanOptions(
      autoEnableFlash: false,
      android: AndroidOptions(
        useAutoFocus: true,
        aspectTolerance: 1.0,
      ),
      strings: {
        'cancel': 'Anuluj',
        'flash_on': 'Włącz latarkę',
        'flash_off': 'Wyłącz latarkę'
      },
    );
    var result = await BarcodeScanner.scan(options: options);
    _barcodeLastResult = result.rawContent;
    if (result.type != ResultType.Barcode) {
      _barcodeLastResult = "-1";
    }
    if (_barcodeLastResult != "-1") {
      _barcode = _barcodeLastResult;
    }
  }

  @override
  Widget build(BuildContext context) {
    ItemModel item = widget.itemModel;

    _oldItem ??= ItemModel(
        itemName: item.itemName,
        itemCount: item.itemCount,
        itemUnit: item.itemUnit,
        itemBarcode: item.itemBarcode,
        isChecked: item.isChecked,
        itemInfo: item.itemInfo,
        listID: item.listID);

    TextEditingController nameController = TextEditingController();
    TextEditingController countController = TextEditingController();
    TextEditingController infoController = TextEditingController();

    nameController.text = item.itemName;
    countController.text = item.itemCount;
    infoController.text = item.itemInfo;

    String unit = "";

    if (unit.isEmpty) {
      unit = item.itemUnit;
    }

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
            if (val!) {
              String newName = nameController.text;
              String newCount = countController.text;
              String newInfo = infoController.text;
              String newUnit = unit;
              ItemModel newItem = ItemModel(
                  itemName: newName,
                  itemCount: newCount,
                  itemUnit: newUnit,
                  itemInfo: newInfo,
                  itemBarcode: item.itemBarcode,
                  isChecked: item.isChecked,
                  listID: item.listID);
              ItemModel oldItemModel = ItemModel(
                  itemName: item.itemName,
                  itemCount: item.itemCount,
                  itemUnit: _oldItem!.itemUnit,
                  itemBarcode: item.itemBarcode,
                  isChecked: item.isChecked,
                  itemInfo: item.itemInfo,
                  listID: item.listID);
              DatabaseService(uid: AuthService().uid)
                  .replaceItem(oldItemModel, newItem);
            }
            Navigator.pop(context);
            return true;
          }
        });
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset : false,
        appBar: AppBar(
          title: Text(item.itemName),
          foregroundColor: Theme.of(context).colorScheme.tertiary,
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {
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
                          DatabaseService(uid: AuthService().uid)
                              .deleteItemFromList(widget.itemModel);
                          Navigator.pop(context);
                        }
                      }
                    });
                  },
                  child: const Icon(Icons.delete),
                )),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    const Text("Nazwa:"),
                    Expanded(
                        child: TextField(
                      textAlign: TextAlign.center,
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
                      textAlign: TextAlign.center,
                      controller: countController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          try {
                            final text = newValue.text;
                            if (text.isNotEmpty) double.parse(text);
                            return newValue;
                          } catch (e) {
                            //do nothing
                          }
                          return oldValue;
                        }),
                      ],
                    )),
                    DropdownButton<String>(
                        value: unit,
                        items:
                            units.map<DropdownMenuItem<String>>((String val) {
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
                const Text('Dodatkowe informacje:'),
                TextField(
                  textAlign: TextAlign.center,
                  controller: infoController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  //Normal textInputField will be displayed
                  maxLines: 5, // when user presses enter it will adapt to it
                ),
                const Text('Kod kreskowy:'),
                BarcodeWidget(
                  barcode: Barcode.ean13(drawEndChar: true),
                  data: item.itemBarcode,
                  color: GbPalette.yellow,
                  errorBuilder: (context, error) => Center(child: Text("Dodaj kod kreskowy aby się tutaj pojawił")),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () async {
                          await _scan();
                          if (_barcodeLastResult != "-1") {
                            setState(() {
                              item.itemBarcode = _barcode;
                            });
                            DatabaseService(uid: AuthService().uid)
                                .replaceItem(_oldItem!, item);
                            _oldItem!.itemBarcode = _barcode;
                          }
                        },
                        child: item.itemBarcode.isEmpty
                            ? const Text('Dodaj kod kreskowy')
                            : const Text('Zmień kod kreskowy')),
                    OutlinedButton(
                        onPressed: () async {
                          await _scan();
                          if (_barcodeLastResult != "-1") {
                            if (_barcode == item.itemBarcode) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Wynik skanowania'),
                                  content: const Text('Ten sam produkt!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Wynik skanowania'),
                                  content: const Text('Inny produkt!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'OK'),
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Sprawdź kod kreskowy')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
