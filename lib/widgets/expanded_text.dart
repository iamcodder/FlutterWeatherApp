import 'package:flutter/material.dart';

class ExpandedText extends StatelessWidget {
  ExpandedText(this.txt, this.textStyle, {this.expandedValue = 1});

  final String txt;
  final TextStyle textStyle;
  final int expandedValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: expandedValue,
      child: Center(
        child: Text(
          '$txt',
          style: textStyle,
        ),
      ),
    );
  }
}
