import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherapp/data/weather_model.dart';

class Networking {
  Networking(this._latitude, this._longitude, this._apiKey);

  double _latitude;
  double _longitude;
  String _apiKey;

  Future<WeatherModel> fetchDeneme() async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$_latitude&lon=$_longitude&appid=$_apiKey&units=metric');
    return WeatherModel.fromJson(json.decode(response.body));
  }
}
