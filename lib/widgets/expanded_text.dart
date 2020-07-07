import 'package:flutter/material.dart';

class ExpandedText extends StatelessWidget {
  ExpandedText(this.txt, this.textStyle,
      {this.expandedValue = 0, this.textColor = Colors.black});

  final String txt;
  final TextStyle textStyle;
  final int expandedValue;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: expandedValue,
      child: Center(
        child: Text(
          '$txt',
          style: textStyle.copyWith(color: textColor),
        ),
      ),
    );
  }
}
