import 'package:geolocator/geolocator.dart';

class Location {
  double _longitude;
  double _latitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);
      _longitude = position.longitude;
      _latitude = position.latitude;
    } catch (e) {
      e.toString();
    }
  }

  double get latitude => _latitude;

  double get longitude => _longitude;
}
