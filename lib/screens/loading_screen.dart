import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/services/networking.dart';
import 'package:weatherapp/utilities/decode.dart';

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

  @override
  void deactivate() {
    super.deactivate();
  }

  void getLocation() async {
    String apiKey = '61a6141389fcb5ab641237c6ae8ffefc';

    Location location = Location();
    await location.getCurrentLocation();

    Networking networking =
        Networking(location.latitude, location.longitude, apiKey);

    await networking.fetchWeather();
    http.Response response = networking.response;

    if (response.statusCode == 200) {
      Decode decode = Decode(response.body);
      decode.decode();
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitWanderingCubes(
          color: Colors.blue,
          duration: const Duration(seconds: 2),
        ),
      ),
    );
  }
}
