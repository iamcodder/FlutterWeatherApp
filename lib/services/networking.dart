import 'package:http/http.dart' as http;

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
}
