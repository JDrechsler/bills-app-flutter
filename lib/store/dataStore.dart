import 'package:bills_app_flutter/models/bill.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DataStore extends ChangeNotifier {
  String data = "This is some data";
  String title = "This is my title";
  bool userIsLoggedIn = false;
  FirebaseUser currentUser = null;

  int myNum = 0;
  Bill updatedBill = Bill();
  List<Bill> bills = [
    Bill(
      billImage: "",
      billTitle: "Phone Bill",
      amount: 300,
      isPaid: false,
      dueDate: 3,
      uuid: Uuid().v1(),
    ),
    Bill(
      billImage: "",
      billTitle: "Phone Bill",
      amount: 300,
      isPaid: false,
      dueDate: 2,
      uuid: Uuid().v1(),
    ),
    Bill(
      billImage: "",
      billTitle: "Phone Bill",
      amount: 300,
      isPaid: true,
      dueDate: 1,
      uuid: Uuid().v1(),
    )
  ];

  void markBillAsPaid(Bill bill) {
    bill.isPaid = true;
    notifyListeners();
  }

  void markBillAsUnpaid(Bill bill) {
    bill.isPaid = false;
    notifyListeners();
  }

  void saveChangesToBill(Bill billOld, Bill billNew) {
    billOld = billNew;
    notifyListeners();
  }

  void setPreviewUpdatedBill(Bill bill) {
    updatedBill = Bill.copyFromBill(bill);
    notifyListeners();
  }

  void updateBill(Bill bill, String targetBillUuid) {
    bills[bills.indexWhere((element) => element.uuid == targetBillUuid)] =
        Bill.copyFromBill(bill);
    notifyListeners();
  }

  void changeString(String newString) {
    data = newString;
    notifyListeners();
  }

  void incNum() {
    myNum++;
    notifyListeners();
  }

  void decNum() {
    myNum--;
    notifyListeners();
  }

  Future<void> setCurrentUserFromSignUp(FirebaseUser newUser) async {
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.currentUser();

      if (user != null) {
        currentUser = user;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> setCurrentUserFromLogin(FirebaseUser existingUser) async {
    try {
      final _auth = FirebaseAuth.instance;
      final user = await _auth.currentUser();

      if (user != null) {
        currentUser = user;
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void clearCurrentUser() {
    currentUser = null;
    notifyListeners();
  }
}
