import 'dart:developer';

import 'package:flutter/foundation.dart';

class Logger {
  Logger._();

  static logToFirebase(err, s) {
    // FirebaseCrashlytics.instance.recordError(err, s);
  }

  static appLogs(msg) {
    if (kDebugMode) {
      log(msg.toString());
    }
  }
}
