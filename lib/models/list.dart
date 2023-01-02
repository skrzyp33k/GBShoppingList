import 'package:gb_shopping_list/models/item.dart';

class ListModel {
  ListModel(
      {this.ID = "",
      required this.listName,
      required this.listItems,
      required this.isTrashed});

  String listName;
  List<ItemModel> listItems;
  bool isTrashed;
  String ID;
}
