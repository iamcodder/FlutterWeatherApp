import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_model.dart';
import 'package:weatherapp/utilities/utilities.dart';
import 'package:weatherapp/widgets/days_of_week.dart';
import 'package:weatherapp/widgets/expanded_text.dart';

class DetailedDegreeScreen extends StatefulWidget {
  int selectedDay;
  int position;
  String selectedTime;
  FetchedWeatherModel weatherModel;

  DetailedDegreeScreen(
      this.selectedDay, this.selectedTime, this.position, this.weatherModel);

  @override
  _DetailedDegreeScreenState createState() => _DetailedDegreeScreenState();
}

class _DetailedDegreeScreenState extends State<DetailedDegreeScreen> {
  List<Color> daysIconsColorList;
  List<TextStyle> textStyleList;
  WeatherModel weatherModel;

  int activeDay = 0;

  @override
  void initState() {
    super.initState();
    int position = parseTime(widget.selectedTime, position: widget.position);
    if (widget.selectedDay == 0)
      weatherModel = decodeWeatherModel(widget.weatherModel, position - 1);
    if (widget.selectedDay == 1)
      weatherModel = decodeWeatherModel(widget.weatherModel, position + 7);
    if (widget.selectedDay == 2)
      weatherModel = decodeWeatherModel(widget.weatherModel, position + 15);

    daysIconsColorList = List();
    addList(daysIconsColorList, Colors.black, Colors.black12);
    textStyleList = List();
    addList(textStyleList, kActiveDaysTextStyle, kPassiveDaysTextStyle);
  }

  void daysClick(int position) {
    setState(() {
      if (activeDay != position) {
        daysIconsColorList[activeDay] = Colors.black12;
        textStyleList[activeDay] = kPassiveDaysTextStyle;

        daysIconsColorList[position] = Colors.black;
        textStyleList[position] = kActiveDaysTextStyle;
        activeDay = position;
      }
    });
  }

  void addList<T>(List<T> genericList, T t1, T t2) {
    genericList.add(t1);
    for (int i = 0; i < 4; i++) {
      genericList.add(t2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 1,
                child: Text('Degree Detail',
                    style: kDaysInfoHeaderActive.copyWith(
                        fontSize: 30, fontWeight: FontWeight.normal)),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        WeatherIcons.day_sunny,
                        size: 20,
                      ),
                    ),
                    ExpandedText(weatherModel.main_temp.toString(),
                        kDaysInfoHeaderActive,
                        expandedValue: 3),
                    ExpandedText('22' + '°', kDaysInfoHeaderActive,
                        expandedValue: 3),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        ExpandedText('Main', kActiveDaysTextStyle),
                        ExpandedText('Normal', kPassiveDaysTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        ExpandedText('Feels', kActiveDaysTextStyle),
                        ExpandedText('20°C', kPassiveDaysTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        ExpandedText('Humidity', kActiveDaysTextStyle),
                        ExpandedText('%33', kPassiveDaysTextStyle)
                      ],
                    ),
                    Row(
                      children: [
                        ExpandedText('Wind', kActiveDaysTextStyle),
                        ExpandedText('22 km/s', kPassiveDaysTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DaysOfWeek(strToSub('Sunday'), WeatherIcons.day_sunny,
                          daysIconsColorList[0], textStyleList[0], () {
                            daysClick(0);
                          }),
                      DaysOfWeek(strToSub('Monday'), WeatherIcons.day_cloudy,
                          daysIconsColorList[1], textStyleList[1], () {
                            daysClick(1);
                          }),
                      DaysOfWeek(strToSub('Tuesday'), WeatherIcons.day_rain,
                          daysIconsColorList[2], textStyleList[2], () {
                            daysClick(2);
                          }),
                      DaysOfWeek(strToSub('Wednesday'), WeatherIcons.day_fog,
                          daysIconsColorList[3], textStyleList[3], () {
                            daysClick(3);
                          }),
                      DaysOfWeek(strToSub('Thursday'), WeatherIcons.day_hail,
                          daysIconsColorList[4], textStyleList[4], () {
                            daysClick(4);
                          }),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
