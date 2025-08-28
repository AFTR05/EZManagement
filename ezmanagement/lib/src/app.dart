import 'dart:ui';

import 'package:bmprogresshud/progresshud.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/environment_config.dart';
import 'package:ezmanagement/src/routes_app.dart';
import 'package:ezmanagement/src/utils/navigation_service.dart';
import 'package:ezmanagement/src/utils/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
  };
}

class EZManagementApp extends StatefulWidget {
  const EZManagementApp({super.key});

  @override
  State<EZManagementApp> createState() => _EZManagementAppState();
}

class _EZManagementAppState extends State<EZManagementApp> {
  @override
  Widget build(BuildContext context) {
    return ProgressHud(
      isGlobalHud: true,
      child: AbsorbPointer(
        absorbing: false,
        child: Listener(
          child: OverlaySupport.global(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: CustomScrollBehavior(),
              navigatorKey: NavigationService.navigationKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              title: EnvironmentConfig.nameApp,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.light,
              navigatorObservers: [NavigationService.myTransitionObserver],
              theme: AppTheme.lightTheme,
              initialRoute: RoutesApp.login,
              onGenerateRoute: RoutesApp.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}

class ColorsApp {}
