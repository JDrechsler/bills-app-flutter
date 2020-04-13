import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PizzaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pizza Page"),
      ),
      body: Column(
        children: <Widget>[
          Text("This is it: ${dataStore.data}"),
          TextField(
            textAlign: TextAlign.center,
            onSubmitted: (newString) {
              dataStore.changeString(newString);
            },
          ),
          Text(dataStore.data),
          Text(
            dataStore.myNum.toString(),
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
