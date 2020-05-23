import 'package:bills_app_flutter/models/bill.dart';
import 'package:bills_app_flutter/screens/addBillScreen.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/widgets/billCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillsPage extends StatelessWidget {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Bills Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dataStore.newBill = Bill();
          showModalBottomSheet(
            context: context,
            builder: (context) => AddBillScreen(),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: (_firestore.collection('billers').snapshots()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final bills = snapshot.data.documents;
                  List<Bill> billsList = [];

                  for (var bill in bills) {
                    var billData = bill.data;
                    Bill currentBill = Bill(
                      amount: billData['amount'],
                      dueDate: billData['dayOfMonth'],
                      billImage: billData['imageUrl'],
                      billTitle: billData['title'],
                      isPaid: billData['isPaid'],
                      uuid: billData['id'],
                    );
                    billsList.add(currentBill);
                  }

                  List<Bill> billsListUnpaid = billsList
                      .where((element) => element.isPaid == false)
                      .toList();
                  billsListUnpaid
                      .sort((a, b) => a.dueDate.compareTo(b.dueDate));

                  List<Bill> billsListPaid = billsList
                      .where((element) => element.isPaid == true)
                      .toList();
                  billsListPaid.sort((a, b) => a.dueDate.compareTo(b.dueDate));

                  List<Bill> billsListSorted = [
                    ...billsListUnpaid,
                    ...billsListPaid
                  ];

                  return Expanded(
                    child: ListView.builder(
                      itemCount: billsListSorted.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BillsCard(
                          bill: billsListSorted[index],
                        );
                      },
                    ),
                  );
                } else {
                  return Text("Snapshot did not contain data.");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
