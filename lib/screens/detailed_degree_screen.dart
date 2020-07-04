import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';
import 'package:weatherapp/widgets/days_of_week.dart';
import 'package:weatherapp/widgets/expanded_text.dart';

class DetailedDegreeScreen extends StatefulWidget {
  int selectedDay;
  int selectedTime;
  WeatherModel weatherModel;

  DetailedDegreeScreen(this.selectedDay, this.selectedTime, this.weatherModel);

  @override
  _DetailedDegreeScreenState createState() => _DetailedDegreeScreenState();
}

class _DetailedDegreeScreenState extends State<DetailedDegreeScreen> {
  DecodeApi _decodeApi;
  IconData currenDateIcon;
  List<IconData> iconList;
  List<IconData> iconList5Days;
  List<String> degreeList;

  DateTime currentDate;
  String date;

  String currentDayDegree;
  String currentNightDegree;

  MediaQueryData queryData;
  double iconSize;

  @override
  void initState() {
    super.initState();

    _decodeApi = DecodeApi(widget.weatherModel);
    iconList = _decodeApi.getIconList(widget.selectedDay);
    iconList5Days = _decodeApi.getIconList5Days();
    degreeList = _decodeApi.getDegreeList(widget.selectedDay);
    getCurrentDate();
    getCurrentDegree();
  }

  List<String> dateList;

  void getCurrentDate() {
    currenDateIcon = iconList[widget.selectedTime];
    currentDate = DateTime.now();

    int day = 0;
    if (widget.selectedDay == 1)
      day = 1;
    else if (widget.selectedDay == 2) day = 2;

    DateTime dateTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day + day,
        currentDate.hour,
        currentDate.minute,
        currentDate.second,
        currentDate.millisecond,
        currentDate.microsecond);

    date = DateFormat('EEEE').format(dateTime);

    dateList = List();

    for (int i = 0; i < 5; i++) {
      DateTime dateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day + i,
          currentDate.hour,
          currentDate.minute,
          currentDate.second,
          currentDate.millisecond,
          currentDate.microsecond);
      dateList.add(DateFormat('EEEE').format(dateTime).substring(0, 1));
    }
  }

  void getCurrentDegree() {
    currentDayDegree = degreeList[widget.selectedTime];
    currentNightDegree = degreeList[degreeList.length - 2];
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    iconSize = queryData.size.width / 11;
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
                        currenDateIcon,
                        size: 20,
                      ),
                    ),
                    ExpandedText(date, kDaysInfoHeaderActive, expandedValue: 3),
                    Expanded(flex: 1, child: SizedBox()),
                    ExpandedText(currentDayDegree + '°', kDaysInfoHeaderActive,
                        expandedValue: 1),
                    ExpandedText(
                        currentNightDegree + '°', kPassiveDaysTextStyle,
                        expandedValue: 1),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        ExpandedText('Main', kActiveDaysTextStyle),
                        ExpandedText('Feels', kActiveDaysTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        ExpandedText(
                            '${widget.weatherModel.list[0].weather[0].main}',
                            kPassiveDaysTextStyle),
                        ExpandedText(
                            '${widget.weatherModel.list[0].main.feels_like.round()}°C',
                            kPassiveDaysTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        ExpandedText('Humidity', kActiveDaysTextStyle),
                        ExpandedText('Wind', kActiveDaysTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        ExpandedText(
                            '%${widget.weatherModel.list[0].main.humidity}',
                            kPassiveDaysTextStyle),
                        ExpandedText(
                            '${widget.weatherModel.list[0].wind.speed} km/s',
                            kPassiveDaysTextStyle),
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
                      DaysOfWeek(dateList[0], iconList5Days[0]),
                      DaysOfWeek(dateList[1], iconList5Days[1]),
                      DaysOfWeek(dateList[2], iconList5Days[2]),
                      DaysOfWeek(dateList[3], iconList5Days[3]),
                      DaysOfWeek(dateList[4], iconList5Days[4]),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
