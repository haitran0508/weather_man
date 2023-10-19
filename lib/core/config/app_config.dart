import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config_constants.dart';

class AppConfig {
  static final AppConfig _singleton = AppConfig._internal();
  static final AppConfig instance = AppConfig();

  static Map<String, dynamic>? _config;

  factory AppConfig() {
    return _singleton;
  }

  AppConfig._internal();

  String getValue(String key) {
    return _config?[key]?.toString() ?? '';
  }

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    const env = String.fromEnvironment(
      ConfigConstants.env,
      defaultValue: ConfigConstants.defaultEnv,
    );
    await setValue(env);
  }

  setValue(String env) async {
    final configString = await rootBundle.loadString(
      ConfigConstants.envConfigPath + env + ConfigConstants.envConfigType,
    );
    _config = json.decode(configString);
  }
}
