import 'package:flutter/material.dart';

class DaysOfWeek extends StatelessWidget {
  IconData icons;
  String text;
  Color bdColor;
  TextStyle style;
  Function onClick;

  DaysOfWeek(this.text, this.icons, this.bdColor, this.style, this.onClick);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(flex: 100, child: Icon(icons, color: bdColor)),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 100, child: Text(text, style: style)),
        ],
      ),
    );
  }
}
