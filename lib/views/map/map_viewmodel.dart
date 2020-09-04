import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:survivalrunner/helpers/location_helper.dart';

class MapViewModel extends ChangeNotifier {
  LatLng _location;

  Future<LatLng> getCurrentLocation() async {
    final location = await Location().getLocation();
    _location = LatLng(location.latitude, location.longitude);
    print(_location);
  }

  Future<CameraPosition> getInitialCameraPosition() async {
    await getCurrentLocation();
    return CameraPosition(
      target: _location,
      zoom: 14,
    );
  }
}
