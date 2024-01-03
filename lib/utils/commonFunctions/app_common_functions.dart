import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rebustar_driver/services/exceptions/data_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../commonWidgets/common_widgets.dart';
import '../utils.dart';

//reuseable functions
Future<bool> willPopCallback() async => false;

//To request permission
Future<bool> requestPermission() async {
  AppConstant.isPermissionGranted = await checkPermission();
  return AppConstant.isPermissionGranted;
}

bool permissionPrompt(BuildContext buildCtxt) {
  bool isNavigate = false;
  showDialog(
      context: buildCtxt,
      builder: (context) {
        return PermissionPrompt(
          tapYes: () async {
            Navigator.pop(context);
            isNavigate = await requestPermission();
          },
          tapCancel: () {
            Navigator.pop(context);
            isNavigate = true;
          },
        );
      });
  return isNavigate;
}

Future<bool> checkOnBoarding() async {
  final AppSecureStorage _storage = locator<AppSecureStorage>();
  String onBoarding = await _storage.readSecureData(SecureStorageConstant.onBoarding) ?? "";
  Logger.appLogs('onBoardingMain $onBoarding');
  return onBoarding == 'done';
}

Future<bool> checkIsLoggedIn() async {
  final AppSecureStorage _storage = locator<AppSecureStorage>();
  String onBoarding = await _storage.readSecureData(SecureStorageConstant.isLoggedIn) ?? "";
  Logger.appLogs('onLoginMain $onBoarding');
  return onBoarding == 'true';
}

Future<bool> checkPermission() async {
  final PermissionHandler _permHandler = locator<PermissionHandler>();
  var isGranted = await _permHandler.checkPermissions();
  Logger.appLogs('permGranted: $isGranted');
  return isGranted;
}

Future<bool> validatePermission() async {
  final PermissionHandler _permHandler = locator<PermissionHandler>();
  var isGranted = await _permHandler.validateAllPermissions();
  Logger.appLogs('permGranted: $isGranted');
  return isGranted;
}

num removeRupeeSymbol(String text) {
  var newText = '';
  if (text.isEmpty) {
    return 0;
  } else if (text.contains('₹')) {
    newText = text.replaceAll('₹', '');
    newText = newText.replaceAll(',', '');
    var num = newText.contains('.') ? double.parse(newText) : int.parse(newText);
    return num;
  } else {
    newText = text.replaceAll(',', '');
    var num = newText.contains('.') ? double.parse(newText) : int.parse(newText);
    return num;
  }
}

bool isStringNotNull(String? str) {
  if (str != null) {
    str = str.trim();
    if (str.isNotEmpty) {
      return true;
    }
  }
  return false;
}

bool isValidList(List? list) {
  if (list != null && list.isNotEmpty) {
    return true;
  } else {
    return false;
  }
}

String errorHandler(AppException appException) {
  var errorMsg = '';
  if (appException.error is String) {
    //Something went wrong error
    errorMsg = appException.error as String;
  } else if (appException.type == ErrorType.dioError) {
    //Dio code error
    var dioError = appException.error as DioError;
    errorMsg = DataException.errorResponseHandler(dioError);
  } else {
    //Status code error
    errorMsg = DataException.handleError(appException.statusCode!);
  }
  Logger.appLogs('errorMsg:: $errorMsg');
  return errorMsg;
}

String getReplacedAmount(String streamValue) {
  if (streamValue.isEmpty) {
    return '0';
  }
  var amount = streamValue.replaceAll(',', '');
  return amount = amount.replaceAll('₹', '');
}

String checkFormat(dynamic value) {
  final formatCurrency = NumberFormat.simpleCurrency(
    locale: 'HI',
    decimalDigits: 0,
  );
  num amount = 0;
  if (value is String) {
    amount = removeRupeeSymbol(value);
  }
  return formatCurrency.format(amount);
}

String getFormatCurrency(dynamic streamAmount) {
  try {
    final formatCurrency = NumberFormat.simpleCurrency(
      locale: 'HI',
      decimalDigits: 0,
    );
    num amount = 0;
    if (streamAmount is String) {
      amount = int.tryParse(streamAmount)!;
    } else {
      amount = streamAmount;
    }

    var value = formatCurrency.format(amount);
    Logger.appLogs('formattedCurrency:: $value');
    return value;
  } catch (e) {
    Logger.appLogs('numberFormatError:: $e');
    return '';
  }
}

void errorAlert(BuildContext context, String errMsg, {Function()? onBackPress}) {
  showDialog(
      context: context,
      builder: (context) {
        return ErrorDialog(errorMsg: errMsg, onBackPress: onBackPress);
      });
}

Future<void> launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String getWorkPhone(String workPhone) {
  if (workPhone.startsWith('+91')) {
    print('workphone : ${workPhone.substring(0, 3)}-${workPhone.substring(3, 13)}');
    return '${workPhone.substring(0, 3)} - ${workPhone.substring(3, 13)}';
  } else {
    return '+91-$workPhone';
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launch(launchUri.toString());
}

void sendEmail(String email) {
  launch("mailto:$email");
}

String convertStreamToNumber(String val) {
  if (!val.contains('₹')) {
    return val;
  }
  return int.tryParse(
    val.substring(1).replaceAll(',', ''),
  ).toString();
}

num checkingValidNumber(String streamValue) {
  num amount = 0.0;
  if (streamValue.contains('.')) {
    amount = double.parse(streamValue);
    Logger.appLogs('doubleParse:: $amount');
    return amount;
  } else {
    amount = int.parse(streamValue);
    Logger.appLogs('intParse:: $amount');
    return amount;
  }
}


Color getTxnTypeColor(String? txnType) {
  if (txnType == 'REFUND' || txnType == 'TOPUP') {
    return Colors.green;
  } else if (txnType == 'REGULAR') {
    return Colors.grey;
  } else if (txnType == 'FAILED') {
    return Colors.red;
  } else {
    return Colors.grey;
  }
}

LatLng? getCurrentLatLng({required Function(void Function()) setState}) {
  LatLng? latLng;
  double? currentLatitude;
  double? currentLongitude;
  Location location = Location();
  setState(() {
    location.getLocation().then(
          (location) {
        print("object permission :: ${location.longitude} ${location.latitude}");
        currentLatitude = location.latitude;
        currentLongitude = location.longitude;
      },
    );
  });
  latLng =
      LatLng(currentLatitude ?? 0.00, currentLongitude ?? 0.00);
  return latLng;
}
