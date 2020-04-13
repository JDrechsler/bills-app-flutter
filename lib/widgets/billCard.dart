import 'package:bills_app_flutter/models/bill.dart';
import 'package:bills_app_flutter/screens/optionsScreen.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillsCard extends StatelessWidget {
  final Bill bill;

  const BillsCard({Key key, this.bill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: bill.isPaid ? Colors.lightGreen : Colors.pink,
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(bill.billIcon, size: 70),
            title: Text(bill.billTitle, style: TextStyle(color: Colors.white)),
            subtitle:
                Text(bill.billSubTitle, style: TextStyle(color: Colors.white)),
            trailing: Text(
              bill.dueDate.toString(),
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
          ),
          ButtonBar(
            children: <Widget>[
              bill.isPaid
                  ? Text("")
                  : FlatButton(
                      onPressed: () {
                        dataStore.markBillAsPaid(bill);
                      },
                      child: Text(
                        "Mark as paid",
                        style:
                            TextStyle(color: Colors.lightGreen, fontSize: 16),
                      ),
                    ),
              FlatButton(
                child: Text('Edit', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  dataStore.setPreviewUpdatedBill(bill);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => OptionsScreen(
                      billCurrent: bill,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
