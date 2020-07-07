import 'package:flutter/material.dart';

class ChangeColorOnText extends StatefulWidget {
  TextStyle style;
  String message;
  bool isActive;
  Color txtColor;

  ChangeColorOnText(this.message, this.isActive, this.style) {
    if (isActive)
      txtColor = Colors.white;
    else
      txtColor = Colors.white54;
  }

  @override
  _ChangeColorOnTextState createState() => _ChangeColorOnTextState();
}

class _ChangeColorOnTextState extends State<ChangeColorOnText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.message,
      style: widget.style.copyWith(color: widget.txtColor),
    );
  }
}
