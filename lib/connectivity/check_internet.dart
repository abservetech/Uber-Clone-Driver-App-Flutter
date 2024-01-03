import 'dart:async';
import 'package:rebustar_driver/connectivity/no_internet.dart';
import 'package:rebustar_driver/utils/config/debugger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../commonWidgets/common_widgets.dart';

class CheckInternet extends StatefulWidget {
  const CheckInternet({Key? key}) : super(key: key);

  @override
  CheckInternetState createState() => CheckInternetState();
}

class CheckInternetState extends State<CheckInternet> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    initConnectivity();
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Logger.appLogs(
        'Couldn\'t check connectivity status error: $e',
      );
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger.appLogs(_connectionStatus == ConnectivityResult.none);
    return _connectionStatus == ConnectivityResult.none
        ? const NoInternet()
        : Scaffold(
            appBar: AppBar(
              title: const Text('Connectivity example app'),
            ),
            body: Column(
              children: [
                BottomButton(
                  label: "next",
                  onTap: () {
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OnBoardingScreen(),
                      ),
                    );*/
                  },
                ),
                Center(
                  child: Text(
                    'Connection Status: ${_connectionStatus.toString()}',
                  ),
                ),
              ],
            ),
          );
  }
}
