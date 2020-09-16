import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; //location tracker 

class Speed extends StatelessWidget {
  var _geolocator = Geolocator(); 
  var _options = LocationOptions(accuracy: LocationAccuracy.high, 
  distanceFilter: 10); //Calcuates location
  Timer _timer;
  var _counter = 5; //Will update speed every 5 seconds
  var speedInMps;

  void get speedUpdater{ //return instantaneous speed every 5 seconds
    _timer = Timer.periodic(Duration(seconds: 1), (timer)) {
      if (_counter > 0) {
        _counter--;
      } else {
        geolocator.getPositionStream(options).listen((position) {
          speedInMps = position.speed; // Instantaneous speed
          _counter = 5; // Repeat cycle
        });
      }
    }
  }
}

