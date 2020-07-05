import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/screens/home_screen.dart';
import 'package:weatherapp/services/location_services.dart';
import 'package:weatherapp/services/networking.dart';
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
    String apiKey = '61a6141389fcb5ab641237c6ae8ffefc';

    LocationServices locationServices = LocationServices();

    bool serviceEnabled = await locationServices.isServiceEnabled();
    while (!serviceEnabled) {
      serviceEnabled = await locationServices.requestService();
      showToast('Please open your location services',
          bdColor: Colors.black54, txtColor: Colors.white);
    }

    bool hasPermission = await locationServices.isPermissionGranted();
    while (!hasPermission) {
      hasPermission = await locationServices.requestPermission();
      showToast('Please allow your location services',
          bdColor: Colors.black54, txtColor: Colors.white);
    }

    await locationServices.getLocationData();

    Networking networking = Networking(
        locationServices.latitude, locationServices.longitude, apiKey);
    bool isApiFetched = await networking.fetchDeneme();

    while (!isApiFetched) {
      showToast('Open your internet connection',
          bdColor: Colors.black54, txtColor: Colors.white);
      isApiFetched = await networking.fetchDeneme();
    }

    FetchedWeatherModel weatherModel = networking.getWeatherModel;

    if (weatherModel.cod == '200') {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
        return CityScreen(weatherModel);
      }), (route) => false);
    } else {
      showToast('${weatherModel.cod}\n${weatherModel.message}',
          bdColor: Colors.red, txtColor: Colors.white);
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: SpinKitFadingFour(
            color: Colors.white,
            duration: const Duration(seconds: 1),
          ),
        ),
      ),
    );
  }
}
