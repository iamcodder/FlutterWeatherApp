import 'package:flutter/material.dart';
import 'package:weatherapp/screens/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              letterSpacing: 1,
              fontFamily: 'Spartan MB',
            ),
          ),
        ),
      ),
      home: LoadingScreen(),
    );
  }
}
