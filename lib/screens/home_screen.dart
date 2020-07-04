import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/gradient_colors.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/screens/detailed_degree_screen.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';
import 'package:weatherapp/widgets/card_days.dart';
import 'package:weatherapp/widgets/change_color_on_text.dart';
import 'package:weatherapp/widgets/degree_charts.dart';
import 'package:weatherapp/widgets/expanded_text.dart';

class CityScreen extends StatefulWidget {
  CityScreen(this.model);

  final WeatherModel model;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  bool todayVisibling = true;
  bool tomorrowVisibling = false;
  bool afterVisibling = false;

  WeatherModel weatherModel;
  DecodeApi decodeApi;

  List<String> degreeList;
  List<String> timeList;
  List<IconData> iconList;
  List<GradientColors> gradientList;

  int selectedDay;

  @override
  void initState() {
    super.initState();
    weatherModel = widget.model;
    decodeApi = DecodeApi(weatherModel);
    selectedDay = 0;
    degreeList = decodeApi.getDegreeList(selectedDay);
    timeList = decodeApi.getTimeList(selectedDay);
    iconList = decodeApi.getIconList(selectedDay);
    gradientList = decodeApi.getGradientList(selectedDay);
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
      timeList = decodeApi.getTimeList(selectedDay);
      iconList = decodeApi.getIconList(selectedDay);
      gradientList = decodeApi.getGradientList(selectedDay);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Icon(
                WeatherIcons.day_sunny,
                color: Colors.deepOrange,
                size: 56,
              ),
            ),
            ExpandedText(
                '${widget.model.list[0].main.temp.round()}°C', kTempTextStyle),
            ExpandedText(widget.model.city.name, kCityTextStyle),
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
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 6.0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: timeList.length,
                  itemBuilder: (BuildContext context, int position) {
                    return CardDays(
                        timeList[position],
                        degreeList[position],
                        iconList[position],
                        gradientList[position].beginColor,
                        gradientList[position].endColor, () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailedDegreeScreen(
                            this.selectedDay, position, this.weatherModel);
                      }));
                    });
                  }),
            ),
            ExpandedText(
                'Additional Info', kTempTextStyle.copyWith(fontSize: 20.0)),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      ExpandedText(
                          'Main', kActiveDaysTextStyle.copyWith(fontSize: 14)),
                      ExpandedText('Humidity',
                          kActiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      ExpandedText('${widget.model.list[0].weather[0].main}',
                          kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                      ExpandedText('%${widget.model.list[0].main.humidity}',
                          kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      ExpandedText('Feels Like',
                          kActiveDaysTextStyle.copyWith(fontSize: 14)),
                      ExpandedText(
                          'Wind', kActiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      ExpandedText(
                          '${widget.model.list[0].main.feels_like.round()}°C',
                          kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                      ExpandedText('${widget.model.list[0].wind.speed} km/s',
                          kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: DegreeChart(degreeList),
            )
          ],
        ),
      ),
    );
  }
}
