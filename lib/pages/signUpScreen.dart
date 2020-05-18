import 'package:bills_app_flutter/pages/homePage.dart';
import 'package:bills_app_flutter/store/dataStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key key}) : super(key: key);
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    DataStore dataStore = Provider.of<DataStore>(context);
    String emailEntered;
    String passwordEntered;

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            Text(
              "Sign up for a new account",
              style: TextStyle(fontSize: 23),
            ),
            SizedBox(
              height: 10,
            ),
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
            SizedBox(
              height: 10,
            ),
            Builder(
              builder: (context) => RaisedButton(
                child: Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  try {
                    AuthResult newUser =
                        await _auth.createUserWithEmailAndPassword(
                            email: emailEntered, password: passwordEntered);

                    if (newUser != null) {
                      await dataStore.setCurrentUserFromSignUp(newUser.user);
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
            )
          ],
        ),
      ),
    );
  }
}
