import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/data/gradient_colors.dart';
import 'package:weatherapp/services/location_services.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';
import 'package:weatherapp/utilities/utilities.dart';
import 'package:weatherapp/widgets/change_color_on_text.dart';
import 'package:weatherapp/widgets/chart.dart';
import 'package:weatherapp/widgets/circular_Bar.dart';
import 'package:weatherapp/widgets/expanded_text.dart';

import 'map_screen.dart';

class CityScreen extends StatefulWidget {
  CityScreen(this.model);

  final FetchedWeatherModel model;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  bool todayVisibling = true;
  bool tomorrowVisibling = false;
  bool afterVisibling = false;
  bool circularIsVisible = false;

  FetchedWeatherModel fetchedWeatherModel;
  DecodeApi decodeApi;

  List<String> degreeList;
  List<String> degreeList2;
  List<String> timeList;
  List<IconData> iconList;
  List<GradientColors> gradientList;

  String currentDate;
  String currentImageName;
  String currentCity;
  dynamic currentDegree;
  String currentDescription;
  GradientColors gradientColors;

  int selectedDay;

  @override
  void initState() {
    super.initState();
    initSettings();
  }

  void initSettings(
      {bool isRefresh = false, double latitude, double longitude}) async {
    FetchedWeatherModel tempModel;

    if (isRefresh) {
      showProgress();
      LocationServices locationServices = LocationServices();
      tempModel = await locationServices.getLocation(
          isLatSetted: true, latitude: latitude, longitude: longitude);

      while (tempModel.cod != '200') {
        showToast('${tempModel.cod}\n${tempModel.message}',
            bdColor: Colors.red, txtColor: Colors.white);
        tempModel = await locationServices.getLocation();
      }
    }

    fetchedWeatherModel = isRefresh == true ? tempModel : widget.model;

    decodeApi = DecodeApi(fetchedWeatherModel);
    selectedDay = 0;
    degreeList = decodeApi.getDegreeList(selectedDay);
    degreeList2 = decodeApi.getDegreeList(selectedDay + 1);
    timeList = decodeApi.getTimeList(selectedDay);
    iconList = decodeApi.getIconList(selectedDay);
    gradientList = decodeApi.getGradientList(selectedDay);

    setNewData();
    hideProgress();
  }

  void setNewData() {
    setState(() {
      DateTime dateTime = parseDate(fetchedWeatherModel.list[0].dt_txt);
      currentDate = DateFormat('EEEE, d MMM,h:mm a').format(dateTime);
      String iconName = fetchedWeatherModel.list[0].weather[0].icon.toString();
      iconName = iconName == '01d' && timeList[0] == '03:00' ? '01n' : iconName;

      gradientColors =
          GradientColors(gradientList[0].beginColor, gradientList[0].endColor);
      currentImageName = decodeApi.getImageName(iconName);

      currentCity = fetchedWeatherModel.city.name;
      currentDegree = fetchedWeatherModel.list[0].main.temp;
      currentDescription = fetchedWeatherModel.list[0].weather[0].description;
    });
  }

  void changedLocation() async {
    LatLng latLng = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return MapScreen(fetchedWeatherModel.city.coord.lat,
          fetchedWeatherModel.city.coord.lon);
    }));
    if (latLng != null) {
      initSettings(
          isRefresh: true,
          latitude: latLng.latitude,
          longitude: latLng.longitude);
    }
  }

  void clickCardDay(int position) {
    setState(() {
      selectedDay = position;
      switch (position) {
        case 0:
          setDayVisiblingColor(true, false, false);
          break;
        case 1:
          setDayVisiblingColor(false, true, false);
          break;
        case 2:
          setDayVisiblingColor(false, false, true);
          break;
      }
    });
  }

  void showProgress() {
    setState(() {
      circularIsVisible = true;
    });
  }

  void hideProgress() {
    setState(() {
      circularIsVisible = false;
    });
  }

  void setDayVisiblingColor(bool todayBool, bool tomorrowBool, bool afterBool) {
    setState(() {
      todayVisibling = todayBool;
      afterVisibling = afterBool;
      tomorrowVisibling = tomorrowBool;

      degreeList = decodeApi.getDegreeList(selectedDay);
      degreeList2 = decodeApi.getDegreeList(selectedDay + 1);
      timeList = decodeApi.getTimeList(selectedDay);
      iconList = decodeApi.getIconList(selectedDay);
      gradientList = decodeApi.getGradientList(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather Forecast',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: gradientColors.beginColor,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    gradientColors.beginColor,
                    gradientColors.endColor
                  ])),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        changedLocation();
                      },
                      child: Icon(Icons.location_on,
                          size: 30, color: Colors.white),
                    ),
                  ),
                  ExpandedText(currentCity, kCityTextStyle,
                      textColor: Colors.white, expandedValue: 1),
                  ExpandedText(currentDate, kCityTextStyle,
                      textColor: Colors.white54, expandedValue: 1),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: EdgeInsets.all(6),
                      child: Image.asset(currentImageName),
                    ),
                  ),
                  ExpandedText(
                      '${double.parse(currentDegree.toString()).round()}°C' +
                          '\n${fetchedWeatherModel.list[0].weather[0].description.toString()}' +
                          '\n',
                      kTempTextStyle,
                      textColor: Colors.white,
                      expandedValue: 2),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: ChangeColorOnText(
                              'Today', todayVisibling, kActiveDaysTextStyle),
                          onTap: () {
                            setState(() {
                              clickCardDay(0);
                            });
                          },
                        ),
                        GestureDetector(
                          child: ChangeColorOnText('Tomorrow',
                              tomorrowVisibling, kPassiveDaysTextStyle),
                          onTap: () {
                            setState(() {
                              clickCardDay(1);
                            });
                          },
                        ),
                        GestureDetector(
                          child: ChangeColorOnText(
                              'After', afterVisibling, kPassiveDaysTextStyle),
                          onTap: () {
                            setState(() {
                              clickCardDay(2);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: BarChartSample1(fetchedWeatherModel, selectedDay),
                  ),
                ],
              ),
            ),
            CustomCircularBar(MediaQuery.of(context).size.width,
                circularIsVisible, 'Updating Degree'),
          ],
        ),
      ),
    );
  }
}
