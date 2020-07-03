import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';

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
  List<String> degreeList;

  DateTime currentDate;
  String date;

  String currentDayDegree;
  String currentNightDegree;

  @override
  void initState() {
    super.initState();
    _decodeApi = DecodeApi(widget.weatherModel);
    iconList = _decodeApi.getIconList(widget.selectedDay);
    degreeList = _decodeApi.getDegreeList(widget.selectedDay);
    getCurrentDate();
    getCurrentDegree();
  }

  void getCurrentDate() {
    currenDateIcon = iconList[widget.selectedTime];
    currentDate = DateTime.now();
    date = DateFormat('EEEE').format(currentDate);
  }

  void getCurrentDegree() {
    currentDayDegree = degreeList[widget.selectedTime];
    currentNightDegree = degreeList[degreeList.length - 2];
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
                        currenDateIcon,
                        size: 20,
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Align(
                            child: Text(date, style: kDaysInfoHeaderActive))),
                    Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Expanded(
                        flex: 1,
                        child: Align(
                            child: Text(currentDayDegree + '°',
                                style: kDaysInfoHeaderActive))),
                    Expanded(
                        flex: 1,
                        child: Align(
                            child: Text(currentNightDegree + '°',
                                style: kPassiveDaysTextStyle))),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            ],
          ),
        ),
      ),
    );
  }
}
