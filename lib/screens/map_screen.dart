import 'package:flutter/material.dart';

import '../views/map/map_view.dart';
import '../widgets/circular_border_button/circular_border_button.dart';
import '../widgets/slider_button/slider_button.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            MapView(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.topCenter,
                  child: SliderButton(),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  alignment: Alignment.bottomCenter,
                  child: CircularBorderButton(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
