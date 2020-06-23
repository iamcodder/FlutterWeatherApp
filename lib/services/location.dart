import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Location {
  double _longitude;
  double _latitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      _longitude = position.longitude;
      _latitude = position.latitude;
      print('long: ' + _longitude.toString());
      print('lati: ' + _latitude.toString());
    } catch (e) {
      e.toString();
    }
  }

  Future<http.Response> getData() async {
    http.Response response;
    try {
      String apiKey = '61a6141389fcb5ab641237c6ae8ffefc';
      String url =
          'http://api.openweathermap.org/data/2.5/weather?lat=$_latitude&lon=$_longitude&appid=$apiKey';

      response = await http.get(url);
    } catch (e) {}
    return response;
  }
}
