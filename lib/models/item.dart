class ItemModel {
  String itemName;
  String itemCount;
  String itemUnit;
  String itemInfo;
  String itemBarcode;
  bool isChecked;
  String listID;

  ItemModel(
      {this.listID = "",
      required this.itemName,
      required this.itemCount,
      required this.itemUnit,
      required this.isChecked,
      this.itemInfo = "",
      this.itemBarcode = ""});

  Map<String, dynamic> get itemNegative {
    return {
      'itemName': itemName,
      'itemCount': itemCount,
      'itemUnit': itemUnit,
      'itemInfo': itemInfo,
      'itemBarcode': itemBarcode,
      'isChecked': isChecked ? false : true,
    };
  }

  Map<String, dynamic> get item {
    return {
      'itemName': itemName,
      'itemCount': itemCount,
      'itemUnit': itemUnit,
      'itemInfo': itemInfo,
      'itemBarcode': itemBarcode,
      'isChecked': isChecked,
    };
  }
}
