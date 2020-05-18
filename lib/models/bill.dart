import 'package:flutter/material.dart';

class Bill {
  String billImage;
  String billTitle;
  int amount;
  bool isPaid;
  int dueDate;
  String uuid;

  Bill({
    this.billImage = "image unset",
    this.billTitle = "billTitle",
    this.amount = 40,
    this.isPaid = false,
    this.dueDate = 1,
    this.uuid,
  });

  Bill.copyFromBill(Bill bill) {
    this.billImage = bill.billImage;
    this.billTitle = bill.billTitle;
    this.isPaid = bill.isPaid;
    this.dueDate = bill.dueDate;
    this.amount = bill.amount;
    this.uuid = bill.uuid;
  }
}
