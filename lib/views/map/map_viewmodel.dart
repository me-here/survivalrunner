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

  // Thanks to Miguel Ruivo for the icon size workaround: https://stackoverflow.com/questions/53633404/how-to-change-the-icon-size-of-google-maps-marker-in-flutter
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

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
