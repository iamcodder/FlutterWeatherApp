import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';

class CardDays extends StatefulWidget {
  final String time;
  final IconData weatherDegreeIcon;
  final String degree;
  final Color bdColor;

  CardDays(this.time, this.degree, this.weatherDegreeIcon, this.bdColor);

  @override
  _CardDaysState createState() => _CardDaysState();
}

class _CardDaysState extends State<CardDays> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      child: Card(
        color: widget.bdColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(widget.time, style: kCardTimeTextStyle),
              Icon(widget.weatherDegreeIcon, color: Colors.white),
              Text(widget.degree + '°C', style: kCardDegreeTextStyle),
            ],
          ),
        ),
      ),
    );
  }
}
