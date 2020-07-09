import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/data/fetched_weather_model.dart';
import 'package:weatherapp/utilities/decode_api.dart';

class BarChartSample1 extends StatefulWidget {
  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  BarChartSample1(this.fetchedWeatherModel, this.daysOfWeekPosition);

  final FetchedWeatherModel fetchedWeatherModel;
  int daysOfWeekPosition;

  @override
  State<StatefulWidget> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;
  bool isPlaying = false;

  DecodeApi decodeApi;

  @override
  void initState() {
    super.initState();
    decodeApi = DecodeApi(widget.fetchedWeatherModel);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          BarChart(
            mainBarData(),
            swapAnimationDuration: animDuration,
          ),
        ],
      ),
    );
  }

  //parametre olarak tıklanan gün verisi gösterilmeis lazım.int position gibi
  // ve o position da listeden çekilmeli getDegreeList(position)[i] gibi
  //2.günün verilerini göster gibi
  List<BarChartGroupData> showingGroups() {
    List<BarChartGroupData> tempList = List();
    for (int i = 0;
        i < decodeApi.getTimeList(widget.daysOfWeekPosition).length;
        i++) {
      tempList.add(makeGroupData(i,
          double.parse(decodeApi.getDegreeList(widget.daysOfWeekPosition)[i]),
          isTouched: i == touchedIndex));
    }
    return tempList;
  }

  BarChartGroupData makeGroupData(
    //x bar konumunu gösteriyor
    int x,
    //y ise beyaz renki çubuğu gösteriyor.Yani kaç derece olduğunu
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          //y beyaz bara basınca oluşan sarı barın yüksekliğini ayarlıyor
          y: isTouched ? y + 5 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            //y maksimum dereceyi gösteriyor yani yeşil renkli bar uzunluğu
            // burada derecelerin ortalama değerini bulup onun 2 katı uzunluğu
            //yapabiliriz.Yeşil renkli bar güzel olabilir o zaman
            y: 50,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
//              Model listesinden tıklanan itemin derecesini gösteririz
//              String weekDay = List<WeatherModel>[group.x.toInt()].toString();
              int position = group.x.toInt();
              String weekDay =
                  decodeApi.getDegreeList(widget.daysOfWeekPosition)[position];
              return BarTooltipItem(
                  weekDay +
                      '°C\n' +
                      decodeApi.getDescriptionList(
                          widget.daysOfWeekPosition)[position],
                  TextStyle(color: Colors.yellow));
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! FlPanEnd &&
                barTouchResponse.touchInput is! FlLongPressEnd) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            //saat listesi lazım list[value] diyerek saati alır setleriz
            return decodeApi
                .getTimeList(widget.daysOfWeekPosition)[value.toInt()]
                .substring(0, 2);
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
