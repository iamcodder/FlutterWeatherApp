import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:weatherapp/utilities/constants.dart';
import 'package:weatherapp/utilities/decode_weather_api.dart';
import 'package:weatherapp/widgets/card_days.dart';
import 'package:weatherapp/widgets/center_text.dart';
import 'package:weatherapp/widgets/change_color_on_text.dart';

class CityScreen extends StatefulWidget {
  CityScreen(this.weatherApi);

  final String weatherApi;

  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  Decode decode;
  bool todayVisibling = true;
  bool tomorrowVisibling = false;
  bool afterVisibling = false;

  @override
  void initState() {
    super.initState();
    decode = Decode(widget.weatherApi);
  }

  void click(int position) {
    setState(() {
      switch (position) {
        case 0:
          {
            todayVisibling = true;
            tomorrowVisibling = false;
            afterVisibling = false;
          }
          break;
        case 1:
          {
            todayVisibling = false;
            tomorrowVisibling = true;
            afterVisibling = false;
          }
          break;
        case 2:
          {
            todayVisibling = false;
            tomorrowVisibling = false;
            afterVisibling = true;
          }
          break;
      }
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
            Icon(
              WeatherIcons.day_sunny,
              color: Colors.deepOrange,
              size: 56,
            ),
            WidgetCenterText('${decode.getTemp()}°C', kTempTextStyle),
            WidgetCenterText(decode.getCityName(), kCityTextStyle),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: ChangeColorOnText(
                      'Today', todayVisibling, kActiveDaysTextStyle),
                  onTap: () {
                    setState(() {
                      click(0);
                    });
                  },
                ),
                GestureDetector(
                  child: ChangeColorOnText(
                      'Tomorrow', tomorrowVisibling, kPassiveDaysTextStyle),
                  onTap: () {
                    setState(() {
                      click(1);
                    });
                  },
                ),
                GestureDetector(
                  child: ChangeColorOnText(
                      'After', afterVisibling, kPassiveDaysTextStyle),
                  onTap: () {
                    setState(() {
                      click(2);
                    });
                  },
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CardDays('16:11', '23', WeatherIcons.day_sunny, Colors.orange),
                CardDays('18:11', '17', WeatherIcons.rain, Colors.deepPurple),
                CardDays('20:11', '14', WeatherIcons.snowflake_cold,
                    Colors.blueAccent),
              ],
            ),
            Container(
                margin: EdgeInsets.all(20),
                width: double.infinity,
                child: Text('Additional Info',
                    style: kTempTextStyle.copyWith(
                      fontSize: 20.0,
                      letterSpacing: 1,
                      fontFamily: 'PatuaOne',
                    ))),
            Row(
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
                    Text('${decode.getMain()}',
                        style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('%${decode.getHumidity()}',
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
                    Text('${decode.getFeelsLike()}°C',
                        style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                    SizedBox(
                      height: 10,
                    ),
                    Text('${decode.getWindSpeed()} km/s',
                        style: kPassiveDaysTextStyle.copyWith(fontSize: 14)),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
