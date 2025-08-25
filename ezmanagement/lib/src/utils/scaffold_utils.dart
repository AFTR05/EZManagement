import 'dart:async';

import 'package:flutter/material.dart';

class ScaffoldUtils {
  static void showSnackBar({
    required BuildContext context,
    required String msg,
    Color color = Colors.black
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg), backgroundColor: color));
  }

  static Future<T?> showModalBottomInAllScreen<T>({
    required BuildContext context,
    bool withCancel = true,
    bool? topSpacer,
    bool? bottomSpacer,
    required Widget child,
    Function(T?)? onCloseEvent,
    bool onlyInCancel = false,
  }) async {
    final completer = Completer<T?>();
    await showModalBottomSheet<T>(
      backgroundColor: Colors.transparent,
      elevation: 2.0,
      isScrollControlled: true,
      context: context,
      isDismissible: withCancel,
      enableDrag: withCancel,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
        minHeight: MediaQuery.of(context).size.height,
      ),
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (withCancel) {
              if (onlyInCancel) {
                Navigator.of(context).pop("exit_event");
              } else {
                Navigator.of(context).pop();
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      if (topSpacer ?? true) const Spacer(),
                      child,
                      if (bottomSpacer ?? true) const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((result) {
      if (onlyInCancel) {
        if (result is String && result == "exit_event") {
          completer.complete(null);
          if (onCloseEvent != null) {
            onCloseEvent(result);
          }
        }
      } else {
        completer.complete(result);
        if (onCloseEvent != null) {
          onCloseEvent(result);
        }
      }
    });

    return completer.future;
  }

  static Future<T?> showModalBottomInAllScreenWithNavigator<T>({
    required BuildContext context,
    bool withCancel = true,
    required String initialRoute,
    required Widget Function(RouteSettings, BuildContext, bool) widgetPage,
  }) async {
    final completer = Completer<T?>();

    await showDialog<T>(
      useRootNavigator: true,
      context: context,
      barrierDismissible: withCancel,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            if (withCancel) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.transparent,
            child: Align(
              alignment: Alignment.center,
              child: Material(
                child: GestureDetector(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Spacer(),
                      OrientationBuilder(
                        builder: (context, orientation) {
                          final screenSize = MediaQuery.of(context).size;
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                      top: const Radius.circular(20.0),
                                      bottom:
                                          orientation == Orientation.portrait
                                              ? const Radius.circular(20.0)
                                              : Radius.zero,
                                    ),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth:
                                        orientation == Orientation.portrait
                                            ? screenSize.width * 0.7
                                            : screenSize.height * 0.7,
                                    maxWidth:
                                        orientation == Orientation.portrait
                                            ? screenSize.width * 0.7
                                            : screenSize.height * 0.7,
                                    minHeight:
                                        orientation == Orientation.portrait
                                            ? screenSize.height * 0.7
                                            : screenSize.width * 0.7,
                                    maxHeight:
                                        orientation == Orientation.portrait
                                            ? screenSize.height * 0.8
                                            : screenSize.width * 0.8,
                                  ),
                                  child: Navigator(
                                    initialRoute: initialRoute,
                                    onGenerateRoute: (settings) {
                                      return MaterialPageRoute(
                                        builder: (contextMaterial) {
                                          return widgetPage(
                                            settings,
                                            contextMaterial,
                                            settings.name == initialRoute,
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((result) {
      completer.complete(result);
    });

    return completer.future;
  }

  static bool isNotificationShowing = false;
}
