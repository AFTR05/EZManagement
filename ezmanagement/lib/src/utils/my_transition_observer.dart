import 'package:ezmanagement/src/utils/navigation_service.dart';
import 'package:flutter/material.dart';

class EZTransitionObserver extends RouteObserver<ModalRoute<dynamic>> {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    NavigationService.currentRouteName = route.settings.name;
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {}

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      NavigationService.currentRouteName = previousRoute.settings.name;
    } else {
      NavigationService.currentRouteName = route.settings.name;
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didStartUserGesture(
      Route<dynamic> route, Route<dynamic>? previousRoute) {}

  @override
  void didStopUserGesture() {}
}
