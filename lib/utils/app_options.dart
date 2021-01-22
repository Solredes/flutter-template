import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../preferences.dart';

Locale _deviceLocale;

Locale get deviceLocale => _deviceLocale;

set deviceLocale(Locale locale) {
  _deviceLocale ??= locale;
}

class AppOptions {
  const AppOptions({
    this.themeMode,
    double textScaleFactor,
    Locale locale,
    this.timeDilation,
  })  : _textScaleFactor = textScaleFactor,
        _locale = locale;

  final ThemeMode themeMode;
  final double _textScaleFactor;
  final Locale _locale;
  final double timeDilation;

  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == -1) {
      return useSentinel ? -1 : MediaQuery.of(context).textScaleFactor;
    } else {
      return _textScaleFactor;
    }
  }

  Locale get locale => _locale ?? deviceLocale;

  AppOptions copyWith({
    ThemeMode themeMode,
    double textScaleFactor,
    Locale locale,
    double timeDilation,
  }) {
    return AppOptions(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      locale: locale ?? this.locale,
      timeDilation: timeDilation ?? this.timeDilation,
    );
  }

  factory AppOptions.fromJson(Map<String, dynamic> json) => AppOptions(
        themeMode: json["themeMode"] != null
            ? ThemeMode.values[json["themeMode"]]
            : null,
        locale: json["locale"] != null ? Locale(json["locale"]) : null,
        timeDilation: json["timeDilation"],
        textScaleFactor: json["textScaleFactor"],
      );

  Map<String, dynamic> toJson() => {
        "themeMode": themeMode.index,
        "locale": locale.languageCode,
        "timeDilation": timeDilation,
        "textScaleFactor": _textScaleFactor,
      };

  @override
  bool operator ==(Object other) =>
      other is AppOptions &&
      themeMode == other.themeMode &&
      _textScaleFactor == other._textScaleFactor &&
      locale == other.locale &&
      timeDilation == other.timeDilation;

  @override
  int get hashCode => hashValues(
        themeMode,
        _textScaleFactor,
        locale,
        timeDilation,
      );

  static AppOptions of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    return scope.modelBindingState.currentModel;
  }

  static void update(BuildContext context, AppOptions newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>();
    scope.modelBindingState.updateModel(newModel);
  }
}

class ApplyTextOptions extends StatelessWidget {
  const ApplyTextOptions({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final options = AppOptions.of(context);
    final textScaleFactor = options.textScaleFactor(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor: textScaleFactor,
      ),
      child: child,
    );
  }
}

class _ModelBindingScope extends InheritedWidget {
  _ModelBindingScope({
    Key key,
    @required this.modelBindingState,
    Widget child,
  })  : assert(modelBindingState != null),
        super(key: key, child: child);

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  ModelBinding({
    Key key,
    this.initialModel = const AppOptions(),
    this.child,
  })  : assert(initialModel != null),
        super(key: key);

  final AppOptions initialModel;
  final Widget child;

  @override
  _ModelBindingState createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  AppOptions currentModel;
  Timer _timeDilationTimer;
  Preferences _prefs = Preferences();

  @override
  void initState() {
    super.initState();
    currentModel = widget.initialModel;
  }

  @override
  void dispose() {
    _timeDilationTimer?.cancel();
    _timeDilationTimer = null;
    super.dispose();
  }

  void handleTimeDilation(AppOptions newModel) {
    if (currentModel.timeDilation != newModel.timeDilation) {
      _timeDilationTimer?.cancel();
      _timeDilationTimer = null;
      if (newModel.timeDilation > 1) {
        _timeDilationTimer = Timer(Duration(milliseconds: 150), () {
          timeDilation = newModel.timeDilation;
        });
      } else {
        timeDilation = newModel.timeDilation;
      }
    }
  }

  void updateModel(AppOptions newModel) {
    if (newModel != currentModel) {
      if (newModel.themeMode.index == 0) {
        newModel.copyWith(themeMode: null);
      }

      String modelText = jsonEncode(newModel.toJson());

      handleTimeDilation(newModel);
      _prefs.appModel = modelText;
      setState(() {
        currentModel = newModel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(
      modelBindingState: this,
      child: widget.child,
    );
  }
}
