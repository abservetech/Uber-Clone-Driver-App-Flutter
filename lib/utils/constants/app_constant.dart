import 'dart:io';
import 'dart:ui';

import 'package:permission_handler/permission_handler.dart';

enum ErrorType {
  dioError,
  firebaseError,
  appError,
}

class AppConstant {
  static bool isBoarding = false;
  static bool isLoggedIn = false;
  static bool isPermissionGranted = false;

  // static UserProfile? userProfile;

  static const List<String> reasons = [
    'Shopping',
    'Early loan re-payment',
    'Medical Expense',
    'Credit Card Bill',
    'Others'
  ];
  static const termsOfUseUrl = 'https://jifytestbucket.s3.ap-south-1.amazonaws.com/Legal/TermsOfUser.pdf';
  static const kmTermsUrl = 'https://jifytestbucket.s3.ap-south-1.amazonaws.com/Legal/KMTermsOfUse.pdf';
  static const privacyPolicy = 'https://jifytestbucket.s3.ap-south-1.amazonaws.com/Legal/PrivacyPolicy.pdf';

  static String tartanWebUser = 'TARTAN_WEB_USER';
  static String tartanNativeUser = 'TARTAN_NATIVE_USER';
  static String firstTimeUser = 'FIRST_TIME_USER';
  static String userDoesNotExist = 'USER_DOES_NOT_EXIST';
  static String validUserExit = 'VALID_USER_EXIT';
  static String kycDoneStatus = 'DONE';
  static String kycPendingStatus = 'PENDING';
  static String kycNotStartedStatus = 'NOTSTARTED';
  static String digiLocker = 'digilocker';
  static String noDigiLocker = 'no_digilocker';
  static String helpEmail = 'preeti@jify.co';
  static List<Permission> permissions = [
    Permission.location,
    Permission.camera,
    Permission.storage,
    Permission.microphone,
    if (Platform.isAndroid) Permission.bluetooth,
  ];
  static String enterValidAmount = 'Enter valid amount';
  static String errMaxAmount = 'You entered more than maximum amount';

  static String gMapKey = Platform.isAndroid ? "AIzaSyCgX8fVnxc1Kajx4nNrGsgfdaws59A3Gk4":"AIzaSyBZvKhc06Ms4EXO2ApwcB99LUEwQrrL8f0";

  static const List<Locale> supportedLocales = [
    Locale("af"),
    Locale("am"),
    Locale("ar"),
    Locale("az"),
    Locale("be"),
    Locale("bg"),
    Locale("bn"),
    Locale("bs"),
    Locale("ca"),
    Locale("cs"),
    Locale("da"),
    Locale("de"),
    Locale("el"),
    Locale("en"),
    Locale("es"),
    Locale("et"),
    Locale("fa"),
    Locale("fi"),
    Locale("fr"),
    Locale("gl"),
    Locale("ha"),
    Locale("he"),
    Locale("hi"),
    Locale("hr"),
    Locale("hu"),
    Locale("hy"),
    Locale("id"),
    Locale("is"),
    Locale("it"),
    Locale("ja"),
    Locale("ka"),
    Locale("kk"),
    Locale("km"),
    Locale("ko"),
    Locale("ku"),
    Locale("ky"),
    Locale("lt"),
    Locale("lv"),
    Locale("mk"),
    Locale("ml"),
    Locale("mn"),
    Locale("ms"),
    Locale("nb"),
    Locale("nl"),
    Locale("nn"),
    Locale("no"),
    Locale("pl"),
    Locale("ps"),
    Locale("pt"),
    Locale("ro"),
    Locale("ru"),
    Locale("sd"),
    Locale("sk"),
    Locale("sl"),
    Locale("so"),
    Locale("sq"),
    Locale("sr"),
    Locale("sv"),
    Locale("ta"),
    Locale("tg"),
    Locale("th"),
    Locale("tk"),
    Locale("tr"),
    Locale("tt"),
    Locale("uk"),
    Locale("ug"),
    Locale("ur"),
    Locale("uz"),
    Locale("vi"),
    Locale("zh")
  ];

}
