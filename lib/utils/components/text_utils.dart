import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FontWeight getFontWeight(int fontWeight) {
  switch (fontWeight) {
    case 100:
      return FontWeight.w100;

    case 200:
      return FontWeight.w200;

    case 300:
      return FontWeight.w300;

    case 400:
      return FontWeight.w400;

    case 500:
      return FontWeight.w500;

    case 600:
      return FontWeight.w600;

    case 700:
      return FontWeight.w700;

    case 800:
      return FontWeight.w800;

    case 900:
      return FontWeight.w900;
  }
  return FontWeight.normal;
}

Color getColorFromHex(String colorCode) {
  if(colorCode.isNotEmpty){
    final value = int.tryParse('0xff${colorCode.substring(1, colorCode.length)}');
    return Color(value!);
  }else{
    return Colors.grey;
  }
}
