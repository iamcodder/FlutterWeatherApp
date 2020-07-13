import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/services/location_services.dart';
import 'package:weatherapp/utilities/utilities.dart';

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

  void getLocation() async {
    LocationServices locationServices = LocationServices();
    FetchedWeatherModel weatherModel = await locationServices.getLocation();

    while (weatherModel.cod != '200') {
      showToast('${weatherModel.cod}\n${weatherModel.message}',
          bdColor: Colors.red, txtColor: Colors.white);
      weatherModel = await locationServices.getLocation();
    }

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return HomeScreen(weatherModel);
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: SpinKitWave(
            color: Colors.white,
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }
}
