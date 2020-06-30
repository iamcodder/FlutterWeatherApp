import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/weather_model.dart';

class DecodeApi {
  WeatherModel weatherModel;

  DecodeApi(this.weatherModel) {
    _timeList0 = List();
    _timeList1 = List();
    _timeList2 = List();
    _timeList3 = List();
    _timeList4 = List();
    _degreeList0 = List();
    _degreeList1 = List();
    _degreeList2 = List();
    _degreeList3 = List();
    _degreeList4 = List();
    _iconList0 = List();
    _iconList1 = List();
    _iconList2 = List();
    _iconList3 = List();
    _iconList4 = List();
    _decodeDate();
  }

  List<String> _timeList0;
  List<String> _timeList1;
  List<String> _timeList2;
  List<String> _timeList3;
  List<String> _timeList4;

  List<String> _degreeList0;
  List<String> _degreeList1;
  List<String> _degreeList2;
  List<String> _degreeList3;
  List<String> _degreeList4;

  List<IconData> _iconList0;
  List<IconData> _iconList1;
  List<IconData> _iconList2;
  List<IconData> _iconList3;
  List<IconData> _iconList4;

  void _decodeDate() {
    _addList(_timeList0, _degreeList0, _iconList0);
    _addList(_timeList1, _degreeList1, _iconList1);
    _addList(_timeList2, _degreeList2, _iconList2);
    _addList(_timeList3, _degreeList3, _iconList3);
    _addList(_timeList4, _degreeList4, _iconList4);
  }

  int indis = -1;
  int i = -1;
  int j = -1;

  void _addList(List dateList, List degreeList, List iconList) {
    bool isDone = false;
    while (!isDone) {
      indis++;
      String time =
          weatherModel.list[indis].dt_txt.toString().substring(11, 16);
      if (time == '00:00' && dateList.length >= 1) {
        isDone = true;
      }
      dateList.add(time);
    }

    while (i < indis) {
      i++;
      String temp = weatherModel.list[i].main.temp.toString().split('.')[0];
      degreeList.add(temp);
    }

    while (j < indis) {
      j++;
      iconList.add(_getIcon(weatherModel.list[j].weather[0].icon));
    }
    indis--;
    i--;
    j--;
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

  List<String> getTimeList(int position) {
    if (position == 0)
      return _timeList0;
    else if (position == 1)
      return _timeList1;
    else if (position == 2)
      return _timeList2;
    else if (position == 3)
      return _timeList3;
    else if (position == 4) return _timeList4;
  }

  List<String> getDegreeList(int position) {
    if (position == 0)
      return _degreeList0;
    else if (position == 1)
      return _degreeList1;
    else if (position == 2)
      return _degreeList2;
    else if (position == 3)
      return _degreeList3;
    else if (position == 4) return _degreeList4;
  }

  List<IconData> getIconList(int position) {
    if (position == 0)
      return _iconList0;
    else if (position == 1)
      return _iconList1;
    else if (position == 2)
      return _iconList2;
    else if (position == 3)
      return _iconList3;
    else if (position == 4) return _iconList4;
  }
}
