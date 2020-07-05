import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg,
    {Color bdColor = Colors.blue, Color txtColor = Colors.white}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: bdColor,
      textColor: txtColor,
      fontSize: 16.0);
  sleep(Duration(seconds: 1));
  Fluttertoast.cancel();
}

String strToSub(String text, {int startValue = 0, int endValue = 1}) =>
    text.substring(startValue, endValue);

int parseTime(String date) {
  if (date == '00:00') {
    return 0;
  } else if (date == '03:00') {
    return 1;
  } else if (date == '06:00') {
    return 2;
  } else if (date == '09:00') {
    return 3;
  } else if (date == '12:00') {
    return 4;
  } else if (date == '15:00') {
    return 5;
  } else if (date == '18:00') {
    return 6;
  } else if (date == '21:00') {
    return 7;
  }
}
