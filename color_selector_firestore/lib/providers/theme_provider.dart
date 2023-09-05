import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    if (_mode != mode) {
      _mode = mode;
      notifyListeners();
      preferences.setString('theme', mode.toString());
    }
  }

  void notify() => notifyListeners();

  ThemeProvider(String theme) {
    if (theme == 'ThemeMode.system') _mode = ThemeMode.system;
    if (theme == 'ThemeMode.dark') _mode = ThemeMode.dark;
    if (theme == 'ThemeMode.light') _mode = ThemeMode.light;
  }

  static ThemeProvider of(BuildContext context, [bool listen = true]) =>
      Provider.of<ThemeProvider>(context, listen: listen);

  static bool isBright(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light;

  static ThemeData def([MaterialColor? primarySwatch]) => ThemeData(
        primarySwatch: primarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        sliderTheme: const SliderThemeData(
          valueIndicatorTextStyle: TextStyle(color: Colors.white),
          showValueIndicator: ShowValueIndicator.always,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      );

  static ThemeData get lightTheme => def(Colors.teal).copyWith(
        scaffoldBackgroundColor: Color(0xffbceacf),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          centerTitle: true,
        ),
        tabBarTheme: TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.blue.shade800),
          ),
          labelColor: Colors.white,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(
          color: Colors.grey[900],
          elevation: 0,
          centerTitle: true,
        ),
        tabBarTheme: const TabBarTheme(
          indicatorSize: TabBarIndicatorSize.label,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelColor: Colors.white,
        ),
        tooltipTheme: TooltipThemeData(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
