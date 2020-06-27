import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/data/weather_model.dart';

class Networking {
  Networking(this._latitude, this._longitude, this._apiKey);

  double _latitude;
  double _longitude;
  String _apiKey;

  http.Response _response;

  Future<void> fetchWeather() async {
    try {
      String url =
          'http://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$_apiKey&units=metric';
      _response = await http.get(url);
    } catch (e) {}
  }

  http.Response get response => _response;

  Future<WeatherModel> fetchDeneme() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$_latitude&lon=$_longitude&appid=$_apiKey');
    return WeatherModel.fromJson(json.decode(response.body));
  }
}
