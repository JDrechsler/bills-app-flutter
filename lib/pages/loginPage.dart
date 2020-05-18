import 'package:bills_app_flutter/pages/homePage.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);
    String emailEntered = "";
    String passwordEntered = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
                onChanged: (value) {
                  emailEntered = value;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: 'you@example.com', labelText: 'E-mail Address')),
            TextFormField(
                onChanged: (value) {
                  passwordEntered = value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: 'Password', labelText: 'Enter your password')),
            Container(
              child: Builder(
                builder: (context) => RaisedButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    try {
                      AuthResult authResult =
                          await _auth.signInWithEmailAndPassword(
                              email: emailEntered, password: passwordEntered);

                      if (authResult != null) {
                        await dataStore
                            .setCurrentUserFromLogin(authResult.user);
                        if (dataStore.currentUser != null) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      }
                    } catch (e) {
                      print(e);

                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            e.toString(),
                          ),
                        ),
                      );
                    }
                  },
                  color: Colors.blue,
                ),
              ),
              margin: EdgeInsets.only(top: 20.0),
            )
          ],
        ),
      ),
    );
  }
}
