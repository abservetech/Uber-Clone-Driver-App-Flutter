import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils.dart';


AppBarTheme appBarThemeData() {
  return  AppBarTheme(
    backgroundColor: AppColorData.appSecondaryColor,
    scrolledUnderElevation: 1,
    foregroundColor: AppColorData.appSecondaryColor,
    shadowColor: AppColorData.transparent,
    surfaceTintColor: AppColorData.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    centerTitle: true,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: AppColorData.appPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color:AppColorData.appPrimaryColor,
    ),
  );
}

FloatingActionButtonThemeData floatingActionButtonThemeData(){
  return FloatingActionButtonThemeData(
    backgroundColor: AppColorData.appPrimaryColor,
    elevation: 0,
    focusColor: AppColorData.transparent,
    foregroundColor: AppColorData.appPrimaryColor,
    hoverColor: AppColorData.transparent,
    splashColor: AppColorData.transparent,
    shape: CircleBorder(),
  );
}

CardTheme cardTheme(){
  return CardTheme(
      color: AppColorData.appSecondaryColor,
      elevation: 3,
      surfaceTintColor: AppColorData.transparent
  );
}

DialogTheme dialogTheme(){
  return DialogTheme(
      backgroundColor: AppColorData.appSecondaryColor,

      elevation: 3,
      surfaceTintColor: AppColorData.transparent
  );
}