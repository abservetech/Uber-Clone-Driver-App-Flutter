import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  static late NavigationService _instance;

  static NavigationService getInstance() {
    _instance = NavigationService._();
    return _instance;
  }

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool? canPop() {
    return _navigationKey.currentState?.canPop();
  }

  void pop({dynamic data}) {
    if (canPop() == true) {
      _navigationKey.currentState?.pop<dynamic>(data);
    }
  }

  Future<dynamic>? navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? navigateToRoute(Route<dynamic> route) {
    return _navigationKey.currentState?.push<dynamic>(route);
  }

  Future<dynamic>? popAllAndNavigateTo(String routeName, {dynamic arguments}) {
    return popUntilAndNavigateTo(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  Future<String> popUntilCount(
    int count, {
    String value = '',
  }) {
    var popCount = 0;
    _navigationKey.currentState?.popUntil((route) => popCount++ == count);
    return Future.value(value);
  }

  Future<dynamic>? popAllAndNavigateToRoute(Route<dynamic> route) {
    return popUntilAndNavigateToRoute(route, (Route<dynamic> route) => false);
  }

  Future<dynamic>? popAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic>? popAndNavigateToRoute(Route<dynamic> route) {
    return _navigationKey.currentState?.pushReplacement(route);
  }

  Future<dynamic>? popUntilAndNavigateTo(
      String routeName, RoutePredicate predicate,
      {dynamic arguments}) {
    return _navigationKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  Future<dynamic>? popUntilAndNavigateToRoute(
      Route<dynamic> route, RoutePredicate predicate) {
    return _navigationKey.currentState
        ?.pushAndRemoveUntil<dynamic>(route, predicate);
  }

  BuildContext? getDialogContext() {
    return _navigationKey.currentState?.overlay?.context;
  }
}
