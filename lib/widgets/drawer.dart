import 'package:bills_app_flutter/pages/billsPage.dart';
import 'package:bills_app_flutter/pages/homePage.dart';
import 'package:bills_app_flutter/pages/loginPage.dart';
import 'package:bills_app_flutter/pages/pizzaPage.dart';
import 'package:bills_app_flutter/pages/signUpScreen.dart';
import 'package:bills_app_flutter/screens/optionsScreen.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget buildDrawer(DataStore dataStore, BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildDrawerHeader(dataStore, context),
          Expanded(
            // child: dataStore.currentUser != null
            //     ? buildDrawerLoggedIn(dataStore, context)
            //     : buildDrawerLoggedOut(context))
            child: buildDrawerLoggedIn(dataStore, context),
          )
        ],
      ),
    ),
  );
}

Widget buildDrawerHeader(DataStore dataStore, BuildContext context) {
  if (dataStore.currentUser != null) {
    return UserAccountsDrawerHeader(
      accountName: Text(dataStore.currentUser.displayName ?? ""),
      accountEmail: Text(dataStore.currentUser.email ?? ""),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Text(
            dataStore.currentUser.email.substring(0, 2).toUpperCase() ?? ""),
      ),
    );
  } else {
    return DrawerHeader(
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        child: Text("Log in"),
      ),
    );
  }
}

ListView buildDrawerLoggedIn(DataStore dataStore, BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
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
      ),
      ListTile(
        title: Text(
          "Log out",
        ),
        onTap: () async {
          FirebaseAuth _auth = FirebaseAuth.instance;
          try {
            await _auth.signOut();
            dataStore.clearCurrentUser();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } catch (e) {
            print(e.toString());
          }
        },
      )
    ],
  );
}

ListView buildDrawerLoggedOut(BuildContext context) {
  return ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      ListTile(
        title: Text(
          "Sign up",
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
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
    ],
  );
}
