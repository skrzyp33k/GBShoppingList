import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gb_shopping_list/models/item.dart';
import 'package:gb_shopping_list/models/list.dart';

class DatabaseService {
  final String? uid;

  DatabaseService({required this.uid});

  final CollectionReference rootCollection =
      FirebaseFirestore.instance.collection('userData');

  Future<void> addNewUser() async {
    await rootCollection.doc(uid).set({'userActive': true});
  }

  Future<void> addNewList(ListModel list) async {
    await rootCollection.doc(uid).collection('lists').add({
      'isTrashed': list.isTrashed,
      'listName': list.listName,
      'items': FieldValue.arrayUnion([])
    });
  }

  Future<void> addItems(String listID, List<ItemModel> items) async {
    var itemsArray = [];
    for (ItemModel item in items) {
      itemsArray.add(item.item);
    }
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(listID)
        .update({'items': FieldValue.arrayUnion(itemsArray)});
  }

  Future<void> setCheckBox(ItemModel item) async {
    await rootCollection.doc(uid).collection('lists').doc(item.listID).update({
      'items': FieldValue.arrayRemove([item.itemNegative])
    });
    await rootCollection.doc(uid).collection('lists').doc(item.listID).update({
      'items': FieldValue.arrayUnion([item.item])
    });
  }

  Future<void> replaceItem(ItemModel oldItem, ItemModel newItem) async {
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(oldItem.listID)
        .update({
      'items': FieldValue.arrayRemove([oldItem.item])
    });
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(newItem.listID)
        .update({
      'items': FieldValue.arrayUnion([newItem.item])
    });
  }

  Future<void> renameList(String listID, String newName) async {
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(listID)
        .update({'listName': newName});
  }

  Future<void> moveListToTrash(String listID) async {
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(listID)
        .update({'isTrashed': true});
  }

  Future<void> moveListFromTrash(String listID) async {
    await rootCollection
        .doc(uid)
        .collection('lists')
        .doc(listID)
        .update({'isTrashed': false});
  }

  Future<void> deleteListFromTrash(String listID) async {
    await rootCollection.doc(uid).collection('lists').doc(listID).delete();
  }

  Future<void> deleteUserSpace() async {
    await rootCollection.doc(uid).collection('lists').get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await rootCollection.doc(uid).delete();
  }

  Future<void> deleteAllListsFromTrash() async {
    await rootCollection.doc(uid).collection('lists').get().then((snapshot) {
      List<DocumentSnapshot> filteredDocs = snapshot.docs
          .where((document) => document.get('isTrashed') == true)
          .toList();
      for (DocumentSnapshot ds in filteredDocs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> deleteItemFromList(ItemModel item) async {
    await rootCollection.doc(uid).collection('lists').doc(item.listID).update({
      'items': FieldValue.arrayRemove([item.item])
    });
  }

  List<ListModel> _getListsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      List<ItemModel> items = [];
      for (var item in doc['items']) {
        items.add(ItemModel(
            itemName: item['itemName'] ?? "",
            itemCount: item['itemCount'] ?? "",
            itemUnit: item['itemUnit'] ?? "szt",
            itemInfo: item['itemInfo'] ?? "",
            itemBarcode: item['itemBarcode'] ?? "",
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
