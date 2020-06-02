import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/store/firestore.dart';
import 'package:bills_app_flutter/widgets/billCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddBillScreen extends StatelessWidget {
  AddBillScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);
    FirestoreStore fireStore = FirestoreStore();

    return Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              "Preview of new bill",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            IgnorePointer(
              child: BillsCard(bill: dataStore.newBill),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter bill title'),
              onChanged: (String value) {
                dataStore.setTitle(dataStore.newBill, value);
              },
            ),
            TextFormField(
              onChanged: (String value) {
                dataStore.setAmount(dataStore.newBill, int.parse(value));
              },
              decoration: InputDecoration(labelText: 'Enter bill amount'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              onChanged: (String value) {
                dataStore.setDueDate(dataStore.newBill, int.parse(value));
              },
              decoration: InputDecoration(labelText: 'Enter bill due date'),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add new bill",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
