import 'package:flutter/material.dart';
import 'package:survivalrunner/locator.dart';
import 'package:survivalrunner/screens/map_screen.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survival Runner',
      home: MapScreen(),
    );
  }
}
