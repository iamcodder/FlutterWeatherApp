import 'package:location/location.dart';

class LocationServices {
  LocationServices() {
    _location = Location();
  }

  Location _location;
  double _latitude;
  double _longitude;

  double get latitude => _latitude;

  double get longitude => _longitude;

  Future<bool> isServiceEnabled() async {
    try {
      bool requestService = await _location.serviceEnabled();

      return requestService;
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestService() async {
    try {
      bool request = await _location.requestService();
      return request;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isPermissionGranted() async {
    try {
      PermissionStatus permission = await _location.hasPermission();

      if (permission == PermissionStatus.granted)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      PermissionStatus permissionResult = await _location.requestPermission();
      if (permissionResult == PermissionStatus.granted)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> getLocationData() async {
    try {
      LocationData locationData = await _location.getLocation();
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
    } catch (e) {
      return;
    }
  }
}
