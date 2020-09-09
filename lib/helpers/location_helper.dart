import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:location/location.dart';

class LocationHelper {
  static Future<LatLng> getCurrentLocation() async {
    final location = await Location().getLocation();
    return LatLng(location.latitude, location.longitude);
  }
}
