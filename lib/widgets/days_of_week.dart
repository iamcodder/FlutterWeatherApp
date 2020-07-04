import 'package:flutter/material.dart';

class DaysOfWeek extends StatelessWidget {
  IconData icons;
  String text;

  DaysOfWeek(this.text, this.icons);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(flex: 100, child: Icon(icons)),
        Expanded(flex: 1, child: SizedBox()),
        Expanded(flex: 100, child: Text(text)),
      ],
    );
  }
}
