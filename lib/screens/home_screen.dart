import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/gradient_colors.dart';
import 'package:weatherapp/data/weather_model.dart';
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

  @override
  void initState() {
    weatherModel = widget.model;
    decodeApi = DecodeApi(weatherModel);
    degreeList = decodeApi.getDegreeList(0);
    timeList = decodeApi.getTimeList(0);
    iconList = decodeApi.getIconList(0);
    gradientList = decodeApi.getGradientList(0);
  }

  void clickCardDay(int position) {
    setState(() {
      switch (position) {
        case 0:
          setDayVisiblingColor(position, true, false, false);
          break;
        case 1:
          setDayVisiblingColor(position, false, true, false);
          break;
        case 2:
          setDayVisiblingColor(position, false, false, true);
          break;
      }
    });
  }

  void setDayVisiblingColor(int clickedItemPosition, bool todayBool,
      bool tomorrowBool, bool afterBool) {
    setState(() {
      todayVisibling = todayBool;
      afterVisibling = afterBool;
      tomorrowVisibling = tomorrowBool;

      degreeList = decodeApi.getDegreeList(clickedItemPosition);
      timeList = decodeApi.getTimeList(clickedItemPosition);
      iconList = decodeApi.getIconList(clickedItemPosition);
      gradientList = decodeApi.getGradientList(clickedItemPosition);
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
                        gradientList[position].endColor);
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
