import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survivalrunner/helpers/location_helper.dart';

class MapViewModel extends ChangeNotifier {
  LatLng _location;
  BitmapDescriptor _followerIcon;

  /// The current location
  LatLng get location => _location;

  /// The bitmap image of a cadet/zombie following you.
  BitmapDescriptor get followerIcon => _followerIcon;

  Future<BitmapDescriptor> getFollowerIcon() async {
    _followerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1),
      "assets/images/yelling_soldier_head.png",
    );
    return _followerIcon;
  }

  Future<void> updateLocation() async {
    _location = await LocationHelper.getCurrentLocation();
  }

  CameraPosition get initialCameraPosition {
    return CameraPosition(
      target: _location,
      zoom: 14,
    );
  }
}
