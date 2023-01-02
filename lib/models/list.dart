import 'package:gb_shopping_list/models/item.dart';

class ListModel {
  ListModel(
      {required this.ID,
      required this.listName,
      required this.listItems,
      required this.isTrashed});

  String listName;
  List<ItemModel> listItems;
  bool isTrashed;
  final String ID;
}
