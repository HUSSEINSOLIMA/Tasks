// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, implementation_imports, unused_import, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_firebase/allPosts.dart';
import 'package:flutter_application_firebase/homePage.dart';
import 'package:flutter_application_firebase/reusablecomponent.dart';
import 'package:hexcolor/hexcolor.dart';

class welcomeScreen extends StatelessWidget {
  var titleContoller = TextEditingController();
  var descripationContoller = TextEditingController();
  var formKey = GlobalKey<FormState>();
  CollectionReference Users = FirebaseFirestore.instance.collection('users');
  CollectionReference Posts = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Welcome in your page',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 156, 155, 155),
      ),
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
                defultSizeBox(),
                defultTextForm(
                    title: 'enter Title',
                    IconinText: Icon(Icons.title),
                    textwillshow: 'please enter first  Titel',
                    nameContoller: titleContoller),
                defultSizeBox(),
                defultTextForm(
                  height: 100.0,
                  width: 10.0,
                  maxlines: 5,
                  title: 'enter the description',
                  IconinText: Icon(Icons.description),
                  textwillshow: 'please enter  description',
                  nameContoller: descripationContoller,
                ),
                defultSizeBox(),
                Row(
                  children: [
                    Builder(builder: (context) {
                      return TextButton(
                        onPressed: (() async {
                          if (formKey.currentState!.validate()) {
                            var current_user =
                                FirebaseAuth.instance.currentUser;
                            await FirebaseFirestore.instance
                                .collection('posts')
                                .doc()
                                .set({
                              'title': titleContoller.text,
                              'descripton': descripationContoller.text,
                              'user': {
                                'email': current_user?.email,
                                'uid': current_user?.uid,
                              },
                            });
                            titleContoller.text == null;
                            descripationContoller.text == null;

                            // Navigator.pop(context);
                          }
                        }),
                        child: Text(
                          'add post ',
                          style: TextStyle(
                              color: HexColor('#42A2C1'), fontSize: 15.0),
                        ),
                      );
                    }),
                    SizedBox(
                      width: 20.0,
                    ),
                    Builder(builder: (context) {
                      return TextButton(
                        onPressed: (() async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => allPosts()),
                          );
                        }),
                        child: Text(
                          'see all posts ',
                          style: TextStyle(
                              color: HexColor('#42A2C1'), fontSize: 15.0),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
