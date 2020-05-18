import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:bills_app_flutter/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      drawer: buildDrawer(dataStore, context),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "My current number:",
              ),
              Text(
                dataStore.myNum.toString(),
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                dataStore.data,
              ),
              RaisedButton(
                  onPressed: () => {dataStore.decNum()}, child: Text("Button")),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: dataStore.incNum,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
