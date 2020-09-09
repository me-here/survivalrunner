import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:survivalrunner/helpers/location_helper.dart';

class MapViewModel extends ChangeNotifier {
  LatLng _location;
  LatLng get location => _location;

  BitmapDescriptor _followerIcon;
  BitmapDescriptor get followerIcon => _followerIcon;

  Future<BitmapDescriptor> getFollowerIcon() async {
    _followerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1),
      "assets/images/yelling_soldier_head.png",
    );
    return _followerIcon;
  }

  Future<LatLng> getCurrentLocation() async {
    final location = await Location().getLocation();
    _location = LatLng(location.latitude, location.longitude);
  }

  CameraPosition getInitialCameraPosition() {
    return CameraPosition(
      target: _location,
      zoom: 14,
    );
  }
}
