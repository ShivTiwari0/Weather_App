import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/res/apptheme.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:weather_app/utils/colors.dart';

class Utils {
  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message, backgroundColor: primaryColor, textColor: textColorBrown);
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          duration: const Duration(seconds: 1),
          message: message,
          backgroundColor: textColorred,
        )..show(context));
  }

  static snackBar(String massage, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        massage,
        style: const TextStyle(color: textColorBrown),
      ),
      backgroundColor: primaryColor,
    ));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void showSnackBar(SnackBar snackBar) {}
}
