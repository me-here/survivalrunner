import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:survivalrunner/views/map/map_viewmodel.dart';


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(),
      builder: (context, child) {
        return FutureBuilder(
          future: Future.wait(
            [
              context.watch<MapViewModel>().updateLocation(),
              context.watch<MapViewModel>().getFollowerIcon(),
            ],
          ),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition:
                        context.watch<MapViewModel>().initialCameraPosition,
                    markers: {
                      Marker(
                        markerId: MarkerId('ffa'),
                        position: context.watch<MapViewModel>().currentLocation,
                        icon: snapshot.data[1],
                      )
                    },
                    onMapCreated: (controller) {
                      _mapController = controller;
                    },
                  )
                : Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.red,
                    ),
                  );
          },
        );
      },
    );
  }
}
