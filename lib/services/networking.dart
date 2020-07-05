import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/data/fetched_weather_model.dart';

class Networking {
  Networking(this._latitude, this._longitude, this._apiKey);

  double _latitude;
  double _longitude;
  String _apiKey;
  FetchedWeatherModel _model;

  Future<bool> fetchDeneme() async {
    try {
      http.Response response = await http.get(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$_latitude&lon=$_longitude&appid=$_apiKey&units=metric');
      _model = FetchedWeatherModel.fromJson(json.decode(response.body));
      return true;
    } catch (e) {
      return false;
    }
  }

  FetchedWeatherModel get getWeatherModel => _model;
}
