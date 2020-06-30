import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/data/weather_model.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_api.dart';
import 'package:weatherapp/widgets/card_days.dart';
import 'package:weatherapp/widgets/center_text.dart';
import 'package:weatherapp/widgets/change_color_on_text.dart';

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

  List<String> degreeList;
  List<String> timeList;
  List<IconData> iconList;

  @override
  void initState() {
    weatherModel = widget.model;
    DecodeApi decodeApi = DecodeApi(weatherModel);
    degreeList = decodeApi.degreeList;
    timeList = decodeApi.timeList;
    iconList = decodeApi.iconList;
  }

  void clickCardDay(int position) {
    setState(() {
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
    todayVisibling = todayBool;
    afterVisibling = afterBool;
    tomorrowVisibling = tomorrowBool;
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
            Expanded(
              flex: 1,
              child: WidgetCenterText(
                  '${widget.model.list[0].main.temp.round()}°C',
                  kTempTextStyle),
            ),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.center,
                  child:
                      WidgetCenterText(widget.model.city.name, kCityTextStyle),
                )),
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
                    return CardDays(timeList[position], degreeList[position],
                        iconList[position], Colors.orange);
                  }),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: Align(
                alignment: Alignment.center,
                child: WidgetCenterText(
                    'Additional Info',
                    kTempTextStyle.copyWith(
                      fontSize: 20.0,
                      letterSpacing: 1,
                      fontFamily: 'PatuaOne',
                    )),
              )),
            ),
            Expanded(
              flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text('Main',
                          style: kActiveDaysTextStyle.copyWith(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Humidity',
                          style: kActiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${widget.model.list[0].weather[0].main}',
                          style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('%${widget.model.list[0].main.humidity}',
                          style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('Feels Like',
                          style: kActiveDaysTextStyle.copyWith(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Wind',
                          style: kActiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  ),
                  Column(
                    children: [
                      Text('${widget.model.list[0].main.feels_like.round()}°C',
                          style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                      SizedBox(
                        height: 10,
                      ),
                      Text('${widget.model.list[0].wind.speed} km/s',
                          style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
