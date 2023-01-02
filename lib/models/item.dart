class ItemModel {
  String itemName;
  String itemCount;
  String itemUnit;
  String itemInfo;
  bool isChecked;
  String listID;

  ItemModel(
      {this.listID = "",
      required this.itemName,
      required this.itemCount,
      required this.itemUnit,
      required this.isChecked,
      this.itemInfo = ""});

  Map<String, dynamic> get itemNegative {
    return {
      'itemName': itemName,
      'itemCount': itemCount,
      'itemUnit': itemUnit,
      'itemInfo': itemInfo,
      'isChecked': isChecked ? false : true,
    };
  }

  Map<String, dynamic> get item {
    return {
      'itemName': itemName,
      'itemCount': itemCount,
      'itemUnit': itemUnit,
      'itemInfo': itemInfo,
      'isChecked': isChecked,
    };
  }
}
