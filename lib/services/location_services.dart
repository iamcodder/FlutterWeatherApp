import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/services/networking.dart';
import 'package:weatherapp/utilities/utilities.dart';

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

  Future<bool> _requestService() async {
    try {
      bool request = await _location.requestService();
      return request;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _isPermissionGranted() async {
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

  Future<bool> _requestPermission() async {
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

  Future<void> _getLocationData() async {
    try {
      LocationData locationData = await _location.getLocation();
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
    } catch (e) {
      return;
    }
  }

  Future<FetchedWeatherModel> getLocation() async {
    String apiKey = '61a6141389fcb5ab641237c6ae8ffefc';

    LocationServices locationServices = LocationServices();

    bool serviceEnabled = await locationServices.isServiceEnabled();
    while (!serviceEnabled) {
      serviceEnabled = await locationServices._requestService();
      showToast('Please open your location services',
          bdColor: Colors.black54, txtColor: Colors.white);
    }

    bool hasPermission = await locationServices._isPermissionGranted();
    while (!hasPermission) {
      showToast('Please allow your location services',
          bdColor: Colors.black54, txtColor: Colors.white);
      hasPermission = await locationServices._requestPermission();
    }

    await locationServices._getLocationData();

    Networking networking = Networking(
        locationServices.latitude, locationServices.longitude, apiKey);
    bool isApiFetched = await networking.fetchDeneme();

    while (!isApiFetched) {
      showToast('Open your internet connection',
          bdColor: Colors.black54, txtColor: Colors.white);
      isApiFetched = await networking.fetchDeneme();
      if (!isApiFetched) {
        showToast('Internet problem',
            bdColor: Colors.black54, txtColor: Colors.white);
      }
    }

    return networking.getWeatherModel;
  }
}
