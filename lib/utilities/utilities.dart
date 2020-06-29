import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(String msg, Color bdColor, Color txtColor) {
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
