import 'package:bills_app_flutter/models/bill.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/widgets/billCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionsScreen extends StatelessWidget {
  final Bill billCurrent;

  OptionsScreen({Key key, this.billCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);

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
                        onPressed: () {
                          dataStore.markBillAsUnpaid(dataStore.updatedBill);
                        },
                        child: Text(
                          "Mark as unpaid",
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    : RaisedButton(
                        color: Colors.lightGreen,
                        onPressed: () {
                          dataStore.markBillAsPaid(dataStore.updatedBill);
                        },
                        child: Text(
                          "Mark as paid",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                RaisedButton(
                  color: Colors.lightBlue,
                  onPressed: () {},
                  child: Text(
                    "Change date",
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
                  onPressed: () {
                    dataStore.updateBill(
                        dataStore.updatedBill, billCurrent.uuid);
                    Navigator.pop(context);
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
