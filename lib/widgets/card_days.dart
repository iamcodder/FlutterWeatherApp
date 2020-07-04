import 'package:flutter/material.dart';
import 'package:weatherapp/utilities/constants.dart';

class CardDays extends StatefulWidget {
  final String time;
  final IconData weatherDegreeIcon;
  final String degree;
  final Color gradientTopColor;
  final Color gradientBottomColor;
  Function function;

  CardDays(this.time, this.degree, this.weatherDegreeIcon,
      this.gradientTopColor, this.gradientBottomColor, this.function);

  @override
  _CardDaysState createState() => _CardDaysState();
}

class _CardDaysState extends State<CardDays> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          width: 100,
          child: Card(
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    widget.gradientTopColor,
                    widget.gradientBottomColor
                  ])),
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
        ),
      ),
    );
  }
}
