import 'package:flutter/material.dart';

class WidgetCenterText extends StatelessWidget {
  WidgetCenterText(this.temp, this.style);

  final String temp;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(
      temp,
      style: style,
      textAlign: TextAlign.center,
    );
  }
}
