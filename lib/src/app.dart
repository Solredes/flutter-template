import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utils/app_options.dart';
import '../utils/app_theme.dart';
import '../config.dart';
import '../preferences.dart';
import '../routes.dart';

class App extends StatelessWidget {
  final config = Config();
  final prefs = Preferences();

  App({
    Key key,
    this.initialRoute,
  });

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    AppOptions appModel;

    if (prefs.appModel.isNotEmpty) {
      appModel = AppOptions.fromJson(jsonDecode(prefs.appModel));
    }

    return ModelBinding(
      initialModel: appModel ??
          AppOptions(
            themeMode: ThemeMode.system,
            textScaleFactor: -1,
            locale: Locale('es', 'CO'),
            timeDilation: timeDilation,
          ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: config.appName,
            debugShowCheckedModeBanner: !config.isProduction,
            themeMode: AppOptions.of(context).themeMode,
            theme: AppThemeData.lightThemeData,
            darkTheme: AppThemeData.darkThemeData,
            initialRoute: initialRoute,
            onGenerateRoute: RouteConfiguration.onGenerateRoute,
            locale: AppOptions.of(context).locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              deviceLocale = locale;
              return locale;
            },
          );
        },
      ),
    );
  }
}
