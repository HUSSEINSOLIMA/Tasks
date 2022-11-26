// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, implementation_imports, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/register.dart';
import 'package:flutter_application_firebase/welcomeScreen.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'reusablecomponent.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var nameContoller = TextEditingController();

  var passContoller = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 40.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  defultSizeBox(),
                  defultTextForm(
                      title: 'enter email',
                      IconinText: Icon(Icons.email),
                      textwillshow: 'please enter email',
                      nameContoller: nameContoller),
                  defultSizeBox(),
                  defultTextForm(
                      title: 'enter password',
                      IconinText: Icon(Icons.lock),
                      textwillshow: 'please enter password',
                      nameContoller: passContoller),
                  defultSizeBox(),
                  Center(
                    child: Builder(builder: (context) {
                      return TextButton(
                        onPressed: (() async {
                          if (formKey.currentState!.validate()) {
                            try {
                              UserCredential _userCredential =
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: nameContoller.text,
                                          password: passContoller.text);

                              if (_userCredential != null) {
                                var _user = _userCredential.user;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => welcomeScreen()),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                Alert(
                                    context: context,
                                    title: "user-not-found",
                                    content: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: nameContoller,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.account_circle),
                                            labelText: 'Username',
                                          ),
                                        ),
                                        TextField(
                                          controller: passContoller,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.lock),
                                            labelText: 'Password',
                                          ),
                                        ),
                                      ],
                                    ),
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]).show();
                              } else if (e.code == 'wrong-password') {
                                Alert(
                                    context: context,
                                    title: "wrong-password",
                                    content: Column(
                                      children: <Widget>[
                                        TextField(
                                          controller: nameContoller,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.account_circle),
                                            labelText: 'Username',
                                          ),
                                        ),
                                        TextField(
                                          controller: passContoller,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.lock),
                                            labelText: 'Password',
                                          ),
                                        ),
                                      ],
                                    ),
                                    buttons: [
                                      DialogButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ]).show();
                              }
                            }
                          }
                        }),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
