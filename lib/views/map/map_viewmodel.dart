import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survivalrunner/helpers/location_helper.dart';

class MapViewModel extends ChangeNotifier {
  LatLng _currentLocation;
  BitmapDescriptor _followerIcon;
  StreamSubscription _locationSub;
  StreamSubscription get locationSub => _locationSub;

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

  void listenToLocationUpdates() {
    _locationSub =
        LocationHelper.location.onLocationChanged.listen((newLoc) async {
      if (newLoc.latitude == currentLocation?.latitude &&
          newLoc.longitude == currentLocation?.longitude) {
        return;
      }
      await updateLocation();
      notifyListeners();
    });
  }
}
