import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/firebase_options.dart';
import 'package:ezmanagement/src/core/helpers/language_app.dart';
import 'package:ezmanagement/translations/codegen_loader.g.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    EasyLocalization(
      supportedLocales: LanguagesApp.availableLanguages,
      assetLoader: const CodegenLoader(),
      fallbackLocale: LanguagesApp.availableLanguages.first,
      path: 'assets/translations',
      saveLocale: true,
      child: const ProviderScope(
        child: EZManagementApp(),
      ),
    ),
  );
}
