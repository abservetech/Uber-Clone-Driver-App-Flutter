import 'package:another_flushbar/flushbar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../utils/utils.dart';

void customSnackBar({ BuildContext? context, required String title, required String message}) {
  if (context != null) {
    Flushbar(
      title: title,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Theme.of(context).primaryColor,
      ),
      leftBarIndicatorColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 5),
    ).show(context);
  }
}

void showFlutterToast({String? msg}){
  Fluttertoast.showToast(
      msg: msg ?? '',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColorData.appPrimaryColor,
      textColor: AppColorData.appSecondaryColor,
      fontSize: 16.0
  );
}

void customToast({String? msg,required BuildContext context,required String image}) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    decoration: BoxDecoration(
      color: AppColorData.appPrimaryColor,
      borderRadius: BorderRadius.circular(10)
    ),
    padding: EdgeInsets.symmetric(horizontal: 14,vertical: 8),
    child: Row(
      children: [
        SvgPicture.asset(image),
        Container(width: 10,),
        Container(
          color: AppColorData.transparent,
          width: MediaQuery.of(context).size.width *0.62,
          child: Text(
              msg ?? "",
              style: TextStyle(
                color: AppColorData.appSecondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )
          ),
        ),
        GestureDetector(
          onTap: (){
            fToast.removeCustomToast();
          },
            child: SvgPicture.asset(
                SVGAssets.cancel_toast_icon)),
      ],
    ),

  );
  fToast.showToast(child: toast,
  toastDuration: Duration(seconds: 5),
  gravity: ToastGravity.TOP);
}