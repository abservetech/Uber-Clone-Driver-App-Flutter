import 'package:flutter/material.dart';
import 'package:rebustar_driver/utils/components/color/app_color.dart';
import 'package:toast/toast.dart';

import '../../utils/config/debugger/logger.dart';

final GlobalKey<ScaffoldMessengerState> snackBarKey =
GlobalKey<ScaffoldMessengerState>();

class ToastUtil {

  static showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(left: 5), child: const Text("Loading")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSnackBar(BuildContext context, String message) {
    Toast.show(message, duration: Toast.lengthShort,
      gravity: Toast.bottom,);
  }

  showShortToast(BuildContext context, String message) {
    Logger.appLogs("the short toast $context");
    Toast.show(message, duration: Toast.lengthLong,
      gravity: Toast.bottom,);
  }

  static showLongToast(BuildContext context, String message) {
    Toast.show(message, duration: Toast.lengthLong, gravity: Toast.bottom);
  }
  static showSnackBarAtCurrentState(String message,{ required SnackBarAction actions,required int seconds}){
    final SnackBar snackBar = SnackBar(
      duration: Duration(seconds: seconds),
      action: actions,
      content: Text(message,style: TextStyle(color: AppColorData.appSecondaryColor),),
    );
    snackBarKey.currentState?.showSnackBar(snackBar);
  }
  static showOkAlert() {}
}