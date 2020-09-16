import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:location/location.dart';

class LocationHelper {
  static final _location = Location();
  static Location get location => _location;

  static Future<LatLng> getCurrentLocation() async {
    final location = await _location.getLocation();
    return LatLng(location.latitude, location.longitude);
  }
}
