import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/gradient_colors.dart';
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
    _gradientList0 = List();
    _gradientList1 = List();
    _gradientList2 = List();
    _gradientList3 = List();
    _gradientList4 = List();
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

  List<GradientColors> _gradientList0;
  List<GradientColors> _gradientList1;
  List<GradientColors> _gradientList2;
  List<GradientColors> _gradientList3;
  List<GradientColors> _gradientList4;

  void _decodeDate() {
    _addList(_timeList0, _degreeList0, _iconList0, _gradientList0);
    _addList(_timeList1, _degreeList1, _iconList1, _gradientList1);
    _addList(_timeList2, _degreeList2, _iconList2, _gradientList2);
    _addList(_timeList3, _degreeList3, _iconList3, _gradientList3);
    _addList(_timeList4, _degreeList4, _iconList4, _gradientList4);
  }

  int indis = -1;

  void _addList(
      List dateList, List degreeList, List iconList, List gradientList) {
    bool isDone = false;
    while (!isDone) {
      indis++;
      String time =
          weatherModel.list[indis].dt_txt.toString().substring(11, 16);
      String temp = weatherModel.list[indis].main.temp.toString().split('.')[0];
      String iconName = weatherModel.list[indis].weather[0].icon;
      IconData iconData = _getIcon(iconName);
      GradientColors gradientColors = _getGradient(iconName);
      if (time == '03:00' && iconName == '01d') {
        iconData = _getIcon('01n');
        gradientColors = _getGradient('01n');
      }
      if (indis == 39 || time == '00:00' && dateList.length != 0) isDone = true;
      dateList.add(time);
      degreeList.add(temp);
      iconList.add(iconData);
      gradientList.add(gradientColors);
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
      case '02n':
        icon = WeatherIcons.night_cloudy;
        break;
      case '03d':
        icon = WeatherIcons.day_cloudy;
        break;
      case '03n':
        icon = WeatherIcons.night_cloudy;
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

  GradientColors _getGradient(String iconName) {
    GradientColors gradientColors;
    switch (iconName) {
      case '01d':
        gradientColors = GradientColors(Color(0xFFfc9562), Color(0xFFc25f67));
        break;
      case '01n':
        gradientColors = GradientColors(Color(0xFF697fb8), Color(0xFF2E485A));
        break;
      case '02d':
        gradientColors = GradientColors(Color(0xFFc25f67), Colors.black54);
        break;
      case '02n':
        gradientColors = GradientColors(Color(0xFF2E485A), Colors.black54);
        break;
      case '03d':
        gradientColors = GradientColors(Colors.black12, Colors.black54);
        break;
      case '03n':
        gradientColors = GradientColors(Colors.black12, Colors.black54);
        break;
      case '04d':
        gradientColors = GradientColors(Colors.black45, Colors.black);
        break;
      case '04n':
        gradientColors = GradientColors(Colors.black45, Colors.black);
        break;
      case '9d':
        gradientColors = GradientColors(Color(0xFF6190E8), Color(0xFFA7BFE8));
        break;
      case '9n':
        gradientColors = GradientColors(Color(0xFF6190E8), Color(0xFFA7BFE8));
        break;
      case '10d':
        gradientColors = GradientColors(Color(0xFFA7BFE8), Color(0xFFc25f67));
        break;
      case '10n':
        gradientColors = GradientColors(Color(0xFFA7BFE8), Color(0xFF2E485A));
        break;
      case '11d':
        gradientColors = GradientColors(Color(0xFFfc9562), Colors.black54);
        break;
      case '11n':
        gradientColors = GradientColors(Color(0xFFfc9562), Colors.black54);
        break;
      case '13d':
        gradientColors = GradientColors(Colors.black12, Colors.black12);
        break;
      case '13n':
        gradientColors = GradientColors(Colors.black12, Colors.black12);
        break;
      case '50d':
        gradientColors = GradientColors(Colors.black12, Colors.black12);
        break;
      case '50n':
        gradientColors = GradientColors(Colors.black12, Colors.black12);
        break;
    }
    return gradientColors;
  }

  List<GradientColors> getGradientList(int position) {
    if (position == 0)
      return _gradientList0;
    else if (position == 1)
      return _gradientList1;
    else if (position == 2) return _gradientList2;
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
