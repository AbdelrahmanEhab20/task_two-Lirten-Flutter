import 'package:flutter/material.dart';
import '../homeWidget/home.dart';
import '../screens/blueScreen_Data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'task two',
      theme: ThemeData(
        fontFamily: 'Avenir LT Std',
      ),
      home: HomeWidgetShow(),
      routes: {SecondScreenShowData.routeName: (ctx) => SecondScreenShowData()},
    );
  }
}
