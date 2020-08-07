import 'package:flutter/material.dart';

enum AppEnvironment {
  DEV,
  SIT,
  UAT,
  PROD,
}

class AppConfig {
  // Singleton object
  static final AppConfig _singleton = AppConfig._internal();
  factory AppConfig() => _singleton;
  AppConfig._internal();

  AppEnvironment appEnvironment;
  String appName;
  String description;
  String baseUrl;
  ThemeData _themeData;

  Color get primaryColor => Color.fromRGBO(0xFF, 0x69, 0x00, 1);
  String get resourceBaseUrl => '$baseUrl/resource';
  String get authBaseUrl => '$baseUrl/auth';
  ThemeData get themeData => _themeData;

  // Set app configuration with single function
  void setAppConfig({
    @required AppEnvironment appEnvironment,
    @required String baseUrl,
    String appName,
    String description,
    ThemeData themeData,
  }) {
    this.appEnvironment = appEnvironment;
    this.appName = appName;
    this.description = description;
    this.baseUrl = baseUrl;
    this._themeData = themeData ?? _themeFactory();
  }

  ThemeData _themeFactory() {
    return ThemeData(
      primaryColor: Color(0xFFFFFFFF),
      accentColor: primaryColor,
    );
  }
}
