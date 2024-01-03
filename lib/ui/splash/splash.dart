 import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:location/location.dart';
import 'package:rebustar_driver/routes/router_pages.gr.dart';
import 'package:flutter/material.dart';

import '../../commonWidgets/brand_logo.dart';
import '../../commonWidgets/common_widgets.dart';
import '../../utils/utils.dart';

 @RoutePage()
class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer? _timer;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    if (AppConstant.isPermissionGranted) {
      Future.delayed(Duration(seconds: 2), () {
        navigateToNextPage();
      });

    } else {
      //Calling API after UI renders
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkLocationAndShowError();

      });
    }
  }
  Future<void> checkLocationAndShowError() async {
    bool isLocationEnabled = await location.serviceEnabled();
    if (!isLocationEnabled && AppConstant.isPermissionGranted == false) {
      Future.delayed(Duration.zero, (){
        permissionPrompt(context);
      });
    } else {
      navigateToNextPage();
    }
  }
  @override
  Widget build(BuildContext context) {
    Logger.appLogs("Splash: Splash screen");
    AutoRouter.of(context);

    return WillPopScope(
      onWillPop: willPopCallback,
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: ThemeColor.whiteColor,
          child: brandLogo(context),
        ),
      ),
    );
  }

  navigateToNextPage() {
    Logger.appLogs('isBoarding:: ${AppConstant.isBoarding}');
    Logger.appLogs('isLoggedIn:: ${AppConstant.isLoggedIn}');
    Logger.appLogs('isGranted:: ${AppConstant.isPermissionGranted}');

    /****************Validating Login Session and onBoard Session**************/
    /* if (Constant.isBoarding) {
      _timer = Timer(const Duration(seconds: 3), () {
        if (Constant.isLoggedIn) {
          context.router.replace(const DashBoardRoute());
        } else {
          context.router.replace(const LoginRoute());
        }
      });
    } else {
      context.router.replace(const OnBoardingRoute());
    }*/
    /********************************END***************************************/
    context.router.replace(const OnBoardingRoute());
  }

  //To request permission
  Future<bool> requestPermission() async {
    AppConstant.isPermissionGranted = await checkPermission();
    navigateToNextPage();
    return AppConstant.isPermissionGranted;
  }
  Future<void> requestLocation() async {
  final Location location = Location();
  AppConstant.isPermissionGranted = await checkPermission();
  bool serviceEnabled = await location.requestService();
   if(serviceEnabled && AppConstant.isPermissionGranted == true){
     Navigator.pop(context);
     navigateToNextPage();
   }
}
  void permissionPrompt(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
        top: Radius.circular(20)
      )),
      backgroundColor: AppColorData.appSecondaryColor,
      builder: (context) => PermissionPrompt(
        tapYes: () {
         //requestPermission();
         requestLocation();
         /*if(AppConstant.isPermissionGranted == true){
           Navigator.pop(context);
         }*/
        },
        tapCancel: () {
          Navigator.pop(context);
          navigateToNextPage();
        },
      ), context: context,
    );
   /* showDialog(
        context: context,
        builder: (context) {
          return PermissionPrompt(
            tapYes: () {
              Navigator.pop(context);
              requestPermission();
            },
            tapCancel: () {
              Navigator.pop(context);
              navigateToNextPage();
            },
          );
        });*/
  }
}
