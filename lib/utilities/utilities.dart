import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

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

DateTime parseDate(String date) {
  String year = date.substring(0, 4);
  String month = date.substring(5, 7);
  String day = date.substring(8, 10);
  String hour = date.substring(11, 13);
  String minute = date.substring(14, 16);
  String second = date.substring(17, 19);
  DateTime dateTime = DateTime(int.parse(year), int.parse(month),
      int.parse(day), int.parse(hour), int.parse(minute), int.parse(second));
  return dateTime;
}

String getDayName(DateTime dateTime) {
  String date = DateFormat('EEEE').format(dateTime);
  return date;
}
