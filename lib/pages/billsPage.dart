import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/widgets/billCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BillsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Bills Page"),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
          ),
          child: ListView.builder(
            itemBuilder: (BuildContext ctxt, int index) {
              return BillsCard(
                bill: dataStore.bills[index],
              );
            },
            itemCount: dataStore.bills.length,
          ),
        ));
  }
}
