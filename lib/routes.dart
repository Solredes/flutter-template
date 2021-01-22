import 'package:flutter/material.dart';

import 'src/ui/pages/home_page.dart';

typedef PathWidgetBuilder = Widget Function(BuildContext, String);

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final PathWidgetBuilder builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    /*Path(
      r'^' + ExampleSlug.routeName + r'/([\w-]+)$',
      (context, match) => ExampleSlug(slug: match),
    ),
    Path(
      r'^' + NormalPage.routeName,
      (context, match) => NormalPage(),
    ),*/
    Path(
      r'^/',
      (context, match) => HomePage(),
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (final path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final firstMatch = regExpPattern.firstMatch(settings.name);
        final match = (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match),
          settings: settings,
        );
      }
    }

    return null;
  }
}
