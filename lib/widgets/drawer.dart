import 'package:bills_app_flutter/pages/billsPage.dart';
import 'package:bills_app_flutter/pages/pizzaPage.dart';
import 'package:bills_app_flutter/screens/optionsScreen.dart';
import 'package:flutter/material.dart';

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Johannes Drechsler"),
            accountEmail: Text("JohannesDrechslerUS@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("JD"),
            ),
          ),
          ListTile(
            title: Text(
              "Pizza",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PizzaPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              "Options",
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (context) => OptionsScreen());
            },
          ),
          ListTile(
            title: Text(
              "Bills",
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BillsPage()),
              );
            },
          )
        ],
      ),
    ),
  );
}
