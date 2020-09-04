import 'package:flutter/material.dart';

class SliderButtonViewModel extends ChangeNotifier {
  double _percentageFilled = 0.8;
  double get percentageFilled => _percentageFilled;
  void changePercentageFilled({delta}) {
    _percentageFilled += delta;
    notifyListeners();
  }
}
