import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/models/list.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  final CollectionReference rootCollection =
      FirebaseFirestore.instance.collection('userData');

  List<ListModel> _getListsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<ItemModel> items = [];
      for (var item in doc['items']) {
        items.add(ItemModel(
            itemName: item['itemName'] ?? "",
            itemCount: item['itemCount'] ?? "",
            itemUnit: item['itemUnit'] ?? "szt",
            itemInfo: item['itemInfo'] ?? "",
            isChecked: item['isChecked'] ?? false,
            listID: doc.id));
      }
      return ListModel(
        listName: doc['listName'] ?? "",
        isTrashed: doc['isTrashed'] ?? "",
        listItems: items,
        ID: doc.id,
      );
    }).toList();
  }

  Stream<List<ListModel>> get lists {
    CollectionReference lists = rootCollection.doc(uid).collection('lists');

    return lists.snapshots().map(_getListsFromSnapshot);
  }
}
