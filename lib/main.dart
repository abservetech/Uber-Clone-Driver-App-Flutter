import 'package:flutter/services.dart';
import 'package:rebustar_driver/app.dart';
import 'package:rebustar_driver/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  //To setup the singleton initialization
  setupLocator();
  //To remove (#) from the navigation url
  setPathUrlStrategy();

  //Check for onBoarding
  AppConstant.isBoarding = await checkOnBoarding();
  //Check for onLogin
  AppConstant.isLoggedIn = await checkIsLoggedIn();
  //Check for permission
  AppConstant.isPermissionGranted = await validatePermission();

  Logger.appLogs('runApp ${AppConstant.isBoarding}:: ${AppConstant.isLoggedIn}');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}
