import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

int backgroundColorBlue = 0XFF0066B3;
int copyrightTextColor = 0XFFE5E5E5;
int fontColorGray = 0XFF77849C;
int fontColorSteelGrey = 0XFF445066;
int midnightBlue = 0XFF001736;
int skyBlue = 0XFFE4F0F8;
int whiteColor = 0XFFFFFFFF;
int borderColor = 0XFFD8DFE9;
void toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
