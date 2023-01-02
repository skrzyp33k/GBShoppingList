class ItemModel {
  String itemName;
  String itemCount;
  String itemUnit;
  String itemInfo;
  bool isChecked;
  final String listID;

  ItemModel(
      {required this.listID,
      required this.itemName,
      required this.itemCount,
      required this.itemUnit,
      required this.isChecked,
      this.itemInfo = ""});
}
