import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/weather_model.dart';

class DecodeApi {
  WeatherModel weatherModel;

  DecodeApi(this.weatherModel) {
    timeList = List();
    timeList2 = List();
    timeList3 = List();
    timeList4 = List();
    timeList5 = List();
    degreeList = List();
    degreeList2 = List();
    degreeList3 = List();
    degreeList4 = List();
    degreeList5 = List();
    iconList = List();
    iconList2 = List();
    iconList3 = List();
    iconList4 = List();
    iconList5 = List();
    _decodeDate();
  }

  List<String> timeList;
  List<String> timeList2;
  List<String> timeList3;
  List<String> timeList4;
  List<String> timeList5;

  List<String> degreeList;
  List<String> degreeList2;
  List<String> degreeList3;
  List<String> degreeList4;
  List<String> degreeList5;

  List<IconData> iconList;
  List<IconData> iconList2;
  List<IconData> iconList3;
  List<IconData> iconList4;
  List<IconData> iconList5;

  void _decodeDate() {
    _addList(timeList, degreeList, iconList);
    _addList(timeList2, degreeList2, iconList2);
    _addList(timeList3, degreeList3, iconList3);
    _addList(timeList4, degreeList4, iconList4);
    _addList(timeList5, degreeList5, iconList5);
  }

  void _addList(List dateList, List degreeList, List iconList) {
    int indis = -1;
    bool isDone = false;
    while (!isDone) {
      indis++;
      dateList
          .add(weatherModel.list[indis].dt_txt.toString().substring(11, 16));
      if (dateList[indis] == '00:00') isDone = true;
    }

    int i = 0;
    while (i <= indis) {
      degreeList
          .add((weatherModel.list[i].main.temp as double).toStringAsFixed(0));
      i++;
    }

    i = 0;
    while (i <= indis) {
      iconList.add(_getIcon(weatherModel.list[i].weather[0].icon));
      i++;
    }
  }

  IconData _getIcon(String iconName) {
    IconData icon;
    switch (iconName) {
      case '01d':
        icon = WeatherIcons.day_sunny;
        break;
      case '01n':
        icon = WeatherIcons.night_clear;
        break;
      case '02d':
        icon = WeatherIcons.day_cloudy;
        break;
      case '02d':
        icon = WeatherIcons.night_cloudy;
        break;
      case '03d':
        icon = WeatherIcons.cloud;
        break;
      case '03n':
        icon = WeatherIcons.cloud;
        break;
      case '04d':
        icon = WeatherIcons.cloudy;
        break;
      case '04n':
        icon = WeatherIcons.cloudy;
        break;
      case '9d':
        icon = WeatherIcons.showers;
        break;
      case '9n':
        icon = WeatherIcons.showers;
        break;
      case '10d':
        icon = WeatherIcons.day_rain;
        break;
      case '10n':
        icon = WeatherIcons.night_rain;
        break;
      case '11d':
        icon = WeatherIcons.thunderstorm;
        break;
      case '11n':
        icon = WeatherIcons.thunderstorm;
        break;
      case '13d':
        icon = WeatherIcons.snow;
        break;
      case '50d':
        icon = WeatherIcons.windy;
        break;
    }
    return icon;
  }
}
