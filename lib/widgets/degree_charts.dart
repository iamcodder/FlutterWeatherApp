import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

class DegreeChart extends StatelessWidget {
  List<String> tempList;
  List<double> degreeList;
  List<String> degreeList2;

  DegreeChart(this.tempList, this.degreeList2) {
    degreeList = List();
    for (int i = 0; i < tempList.length; i++) {
      double temp = double.parse(tempList[i]);
      degreeList.add(temp);
    }
    if (degreeList.length == 1) {
      degreeList.add(double.parse(degreeList2[0]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      height: double.infinity,
      child: Container(
        margin: EdgeInsets.all(10),
        child: new Sparkline(
          data: degreeList,
          lineWidth: 4,
          lineGradient: new LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green, Colors.lightBlueAccent, Colors.blueGrey],
          ),
          pointsMode: PointsMode.all,
          pointSize: 16.0,
          pointColor: Colors.purple,
        ),
      ),
    );
  }
}
