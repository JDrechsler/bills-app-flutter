import 'package:bills_app_flutter/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreStore {
  final _firestore = Firestore.instance;

  Future updateDocument(
      String selectedDocId, Map<String, dynamic> newValues) async {
    await _firestore
        .collection(Constants.firestoreCollectionBills)
        .document(selectedDocId)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  Future addBill() {}
}
