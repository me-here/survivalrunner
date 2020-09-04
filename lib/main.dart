import 'package:flutter/material.dart';

import 'views/map/map_view.dart';
import 'widgets/slider_button/slider_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survival Runner',
      home: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              MapView(),
              Container(
                margin: EdgeInsets.all(8),
                alignment: Alignment.topCenter,
                child: SliderButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
