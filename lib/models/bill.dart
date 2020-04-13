import 'package:flutter/material.dart';

class Bill {
  IconData billIcon;
  String billTitle;
  String billSubTitle;
  bool isPaid;
  int dueDate;
  String uuid;

  Bill({
    this.billIcon = Icons.phone_iphone,
    this.billTitle = "billTitle",
    this.billSubTitle = "billSubTitle",
    this.isPaid,
    this.dueDate = 1,
    this.uuid,
  });

  Bill.copyFromBill(Bill bill) {
    this.billIcon = bill.billIcon;
    this.billTitle = bill.billTitle;
    this.billSubTitle = bill.billSubTitle;
    this.isPaid = bill.isPaid;
    this.dueDate = bill.dueDate;
    this.uuid = bill.uuid;
  }
}
