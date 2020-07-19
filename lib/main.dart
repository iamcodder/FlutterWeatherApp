import 'package:WeatherForecast/screens/loading_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Forecast',
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
