import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:survivalrunner/helpers/location_helper.dart';

class MapViewModel extends ChangeNotifier {
  MapViewModel() {
    listenToLocationUpdates();
  }

  LatLng _currentLocation;
  BitmapDescriptor _followerIcon;

  /// The current location
  LatLng get currentLocation => _currentLocation;

  /// The bitmap image of a cadet/zombie following you.
  BitmapDescriptor get followerIcon => _followerIcon;

  CameraPosition get initialCameraPosition {
    return CameraPosition(
      target: _currentLocation,
      zoom: 14,
    );
  }

  Future<BitmapDescriptor> getFollowerIcon() async {
    _followerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1),
      "assets/images/yelling_soldier_head.png",
    );
    return _followerIcon;
  }

  Future<void> updateLocation() async {
    _currentLocation = await LocationHelper.getCurrentLocation();
  }

  LatLng convertToLatLng(LocationData loc) {
    return LatLng(loc.latitude, loc.longitude);
  }

  void listenToLocationUpdates() {
    LocationHelper.location.onLocationChanged.listen((newLoc) async {
      if (newLoc.latitude == currentLocation?.latitude &&
          newLoc.longitude == currentLocation?.longitude) {
        return;
      }
      _currentLocation = convertToLatLng(newLoc);
      print(_currentLocation);
      print('helOOOOO');
      notifyListeners();
    });
  }
}
