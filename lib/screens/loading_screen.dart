import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void showToast(String msg, Color bdColor, Color txtColor) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bdColor,
        textColor: txtColor,
        fontSize: 16.0);
  }

  void getLocation() async {
    String apiKey = '61a6141389fcb5ab641237c6ae8ffefc';

    Location location = Location();
    bool isGeoFetched = await location.getCurrentLocation();

    if (!isGeoFetched) {
      while (!isGeoFetched) {
        showToast('Allow the geo request', Colors.black54, Colors.white);
        isGeoFetched = await location.getCurrentLocation();
        sleep(Duration(seconds: 1));
        Fluttertoast.cancel();
      }
    }

    Networking networking =
        Networking(location.latitude, location.longitude, apiKey);
    bool isApiFetched = await networking.fetchDeneme();

    if (!isApiFetched) {
      while (!isApiFetched) {
        showToast(
            'Open your internet connection', Colors.black54, Colors.white);
        isApiFetched = await networking.fetchDeneme();
        sleep(Duration(milliseconds: 500));
        Fluttertoast.cancel();
      }
    }

    WeatherModel weatherModel = networking.getWeatherModel;

    DateTime parseTime = DateTime.parse(weatherModel.list[0].dt_txt);

    print(parseTime.year);
    print(parseTime.month);
    print(parseTime.day);
    print(parseTime.hour);
    print(parseTime.minute);
    DateTime nowTime = DateTime.now();
    print(nowTime);

    if (weatherModel.cod == '200') {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return CityScreen(weatherModel);
      }), (route) => false);
    } else {
      showToast('${weatherModel.cod}\n${weatherModel.message}', Colors.red,
          Colors.white);
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitSquareCircle(
          color: Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
