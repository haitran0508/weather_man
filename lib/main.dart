import 'package:flutter/material.dart';
import 'package:weather_man/core/config/app_config.dart';
import 'package:weather_man/core/dependency_injection/dependency_injection.dart';

import 'src/presentation/screens/home_screen.dart';

void main() {
  AppConfig().initialize();
  dependencyRegister();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
