import 'package:WeatherForecast/data/fetched_weather_model.dart';
import 'package:WeatherForecast/key/key.dart';
import 'package:WeatherForecast/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'networking.dart';

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

  Future<bool> _getLocationData() async {
    try {
      LocationData locationData = await _location.getLocation();
      _latitude = locationData.latitude;
      _longitude = locationData.longitude;
      print('lat : $_latitude');
      print('lon : $_longitude');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<FetchedWeatherModel> getLocation(
      {bool isLatSetted = false, double latitude, double longitude}) async {
    String apiKey = getWeatherApiKey();

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

    bool isFetchedLocation = await locationServices._getLocationData();
    while (!isFetchedLocation) {
      isFetchedLocation = await locationServices._getLocationData();
    }

    Networking networking = isLatSetted == true
        ? Networking(latitude, longitude, apiKey)
        : Networking(
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
