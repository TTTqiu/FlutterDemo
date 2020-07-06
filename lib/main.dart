import 'package:flutter/material.dart';
import 'package:myflutterapp/Home.dart';
import 'package:myflutterapp/HttpTest.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      theme: new ThemeData(
        primaryColor: Colors.orange,
      ),
      routes: {"/": (context) => new Home(), "/HttpTest": (context) => new HttpTest()},
    );
  }
}
