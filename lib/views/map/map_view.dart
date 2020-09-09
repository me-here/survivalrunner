import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survivalrunner/views/map/map_viewmodel.dart';

class MapView extends StatelessWidget {
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(),
      builder: (context, child) {
        return FutureBuilder(
          future: Future.wait(
            [
              context.watch<MapViewModel>().getCurrentLocation(),
              context.watch<MapViewModel>().getFollowerIcon(),
            ],
          ),
          builder: (context, snapshot) {
            print(context.watch<MapViewModel>().location);

            // return false
            //     ? Image.asset('assets/images/runner_icon.png')
            //     : Image.asset('assets/images/yelling_soldier_head.png');
            return snapshot.hasData
                ? GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition: context
                        .watch<MapViewModel>()
                        .getInitialCameraPosition(),
                    markers: {
                      Marker(
                        markerId: MarkerId('ffa'),
                        position: context.watch<MapViewModel>().location,
                        icon: snapshot.data[1],
                      )
                    },
                    onMapCreated: (controller) {
                      _mapController.complete(controller);
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
