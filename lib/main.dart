import 'package:flutter/material.dart';
import 'package:tatsamtest/screens/mainhome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tatsam Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MainHome(),
    );
  }
}

