import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/data/gradient_colors.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';
import 'package:weatherapp/utilities/utilities.dart';
import 'package:weatherapp/widgets/change_color_on_text.dart';
import 'package:weatherapp/widgets/chart.dart';
import 'package:weatherapp/widgets/expanded_text.dart';

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

  FetchedWeatherModel fetchedWeatherModel;
  DecodeApi decodeApi;
  WeatherModel decodedWeatherModel;

  List<String> degreeList;
  List<String> degreeList2;
  List<String> timeList;
  List<IconData> iconList;
  List<GradientColors> gradientList;

  String currentDate;
  String currentImageName;
  GradientColors gradientColors;

  int selectedDay;

  @override
  void initState() {
    super.initState();
    fetchedWeatherModel = widget.model;
    decodeApi = DecodeApi(fetchedWeatherModel);
    selectedDay = 0;
    degreeList = decodeApi.getDegreeList(selectedDay);
    degreeList2 = decodeApi.getDegreeList(selectedDay + 1);
    timeList = decodeApi.getTimeList(selectedDay);
    iconList = decodeApi.getIconList(selectedDay);
    gradientList = decodeApi.getGradientList(selectedDay);

    DateTime dateTime = parseDate(fetchedWeatherModel.list[0].dt_txt);
    currentDate = DateFormat('EEEE, d MMM,h:mm a').format(dateTime);

    String iconName = widget.model.list[0].weather[0].icon.toString();
    iconName = iconName == '01d' && timeList[0] == '03:00' ? '01n' : iconName;

    gradientColors =
        GradientColors(gradientList[0].beginColor, gradientList[0].endColor);
    currentImageName = decodeApi.getImageName(iconName);
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
        child: Container(
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
                child: Icon(
                  Icons.location_on,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              ExpandedText(widget.model.city.name, kCityTextStyle,
                  textColor: Colors.white, expandedValue: 1),
              ExpandedText(currentDate, kCityTextStyle,
                  textColor: Colors.white54, expandedValue: 1),
              Expanded(
                flex: 5,
                child: Container(
                  padding: EdgeInsets.all(6),
                  child: Image.asset(
                    currentImageName,
                  ),
                ),
              ),
              ExpandedText(
                '${widget.model.list[0].main.temp.round()}°C' +
                    '\n${widget.model.list[0].weather[0].description.toString()}' +
                    '\n',
                kTempTextStyle,
                textColor: Colors.white,
                expandedValue: 2,
              ),
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
                      child: ChangeColorOnText(
                          'Tomorrow', tomorrowVisibling, kPassiveDaysTextStyle),
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
      ),
    );
  }
}
