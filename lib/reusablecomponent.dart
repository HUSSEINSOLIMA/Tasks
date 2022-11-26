// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Widget defultTextForm({
  required String title,
  required Icon IconinText,
  required String textwillshow,
  required var nameContoller,
  TextInputType? typeofKeyword,
  String textofFiled = '',
  double height = 25.0,
  double width = 25.0,
  int maxlines = 1,
}) =>
    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: HexColor('#D9D9D9'),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          child: TextFormField(
            textAlign: TextAlign.start,
            keyboardType: typeofKeyword,
            showCursor: true,
            enableSuggestions: true,
            controller: nameContoller,
            maxLines: maxlines,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: height, horizontal: width),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
              labelText: ('$title'),
              suffixIcon: IconinText,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$textwillshow';
              }
              return null;
            },
            onChanged: ((value) {
              textofFiled = value;
            }),
          ),
        ),
      ),
    );
Widget defultSizeBox() => SizedBox(
      height: 20.0,
    );
Widget defultmaterailbutton({
  Function? function,
}) =>
    Center(
      child: TextButton(
          onPressed: (() {
            function;
          }),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
          )),
    );

checkVaildUser() {}
