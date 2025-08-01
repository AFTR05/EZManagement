import 'package:ezmanagement/src/utils/my_transition_observer.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
  static String? currentRouteName;
  static EZTransitionObserver myTransitionObserver = EZTransitionObserver();

  static BuildContext? contextReal({
    required BuildContext context,
  }) {
    final contextReal = context.mounted
        ? context
        : NavigationService.navigationKey.currentContext;
    return contextReal;
  }
}
