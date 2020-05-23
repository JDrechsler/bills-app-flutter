import 'package:bills_app_flutter/models/bill.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/store/firestore.dart';
import 'package:bills_app_flutter/widgets/billCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditBillScreen extends StatelessWidget {
  final Bill billCurrent;

  EditBillScreen({Key key, this.billCurrent}) : super(key: key);

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
              "Preview of updated bill",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            IgnorePointer(
              child: BillsCard(bill: dataStore.updatedBill),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                dataStore.updatedBill.isPaid
                    ? RaisedButton(
                        color: Colors.pink,
                        onPressed: () async {
                          dataStore.markBillAsUnpaid(dataStore.updatedBill);
                          print(dataStore.updatedBill.uuid);
                        },
                        child: Text(
                          "Mark as unpaid",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () async {
                          dataStore.markBillAsPaid(dataStore.updatedBill);
                        },
                        child: Text(
                          "Mark as paid",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(DateTime.now().year - 10),
                            lastDate: DateTime(DateTime.now().year + 10))
                        .then((date) => {
                              dataStore.setDueDate(
                                  dataStore.updatedBill, date.day)
                            });
                  },
                  child: Text(
                    "Change date",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Enter new title"),
                        content: TextField(
                          controller: TextEditingController(
                              text: dataStore.updatedBill.billTitle),
                          onChanged: (String value) {
                            dataStore.newTitle = value;
                          },
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              dataStore.setTitle(
                                  dataStore.updatedBill, dataStore.newTitle);
                            },
                            child: Text("Save"),
                          ),
                        ],
                      ),
                      barrierDismissible: true,
                    );
                  },
                  child: Text(
                    "Change title",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Enter new amount"),
                        content: TextField(
                          keyboardType: TextInputType.number,
                          controller: TextEditingController(
                              text: dataStore.updatedBill.amount.toString()),
                          onChanged: (String value) {
                            dataStore.newAmount = int.parse(value);
                          },
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              dataStore.setAmount(
                                  dataStore.updatedBill, dataStore.newAmount);
                            },
                            child: Text("Save"),
                          ),
                        ],
                      ),
                      barrierDismissible: true,
                    );
                  },
                  child: Text(
                    "Change price",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Colors.lightGreen,
                  onPressed: () async {
                    Navigator.pop(context);
                    await fireStore.updateDocument(dataStore.updatedBill.uuid, {
                      'isPaid': dataStore.updatedBill.isPaid,
                      'dayOfMonth': dataStore.updatedBill.dueDate
                    });
                  },
                  child: Text(
                    "Save changes",
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
