import 'package:flutter/material.dart';

import 'config.dart';
import 'preferences.dart';
import 'src/app.dart';
import 'src/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences().initPrefs();

  Config().initConfig(
    appName: 'App Name',
    host: 'baseUrl',
    production: true,
  );

  runApp(App(initialRoute: HomePage.routeName));
}
