// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/homePage.dart';
import 'package:flutter_application_firebase/reusablecomponent.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'welcomeScreen.dart';

class RegisterScreen extends StatelessWidget {
  var nameContoller = TextEditingController();

  var passContoller = TextEditingController();
  var namefirstContoller = TextEditingController();
  var namelastContoller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  CollectionReference Users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Scaffold(
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
                        'Create  A New account',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    defultSizeBox(),
                    defultTextForm(
                        title: 'enter first name',
                        IconinText: Icon(Icons.info_outline),
                        textwillshow: 'please enter first name',
                        nameContoller: namefirstContoller),
                    defultSizeBox(),
                    defultTextForm(
                        title: 'enter last name',
                        IconinText: Icon(Icons.info_outline),
                        textwillshow: 'please enter last name',
                        nameContoller: namelastContoller),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: avoid_unnecessary_containers

                        Builder(builder: (context) {
                          return TextButton(
                            onPressed: (() async {
                              if (formKey.currentState!.validate()) {
                                var result = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: nameContoller.text,
                                        password: passContoller.text);
                                if (result != null) {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(result.user!.uid)
                                      .set({
                                    'firtname': namefirstContoller.text,
                                    'lastname': namelastContoller.text,
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => welcomeScreen()),
                                  );
                                } else {
                                  print('invald user');
                                }
                              }
                            }),
                            child: Text(
                              'Get started ',
                              style: TextStyle(
                                  color: HexColor('#42A2C1'), fontSize: 15.0),
                            ),
                          );
                        }),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ignore: avoid_unnecessary_containers
                        Text(
                          'Already have an account ? ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold),
                        ),

                        Builder(builder: (context) {
                          return TextButton(
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (((context) => homePage()))))
                            },
                            child: Text(
                              'Sign in ',
                              style: TextStyle(
                                  color: HexColor('#42A2C1'), fontSize: 10.0),
                            ),
                          );
                        }),
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  adduser() {
    Users.add({'email': nameContoller.text, 'password': passContoller.text})
        .then((value) => print('user add suss'))
        .catchError((error) => print(error));
  }
}
