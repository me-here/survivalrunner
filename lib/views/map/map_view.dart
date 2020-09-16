import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
<<<<<<< HEAD
import 'package:survivalrunner/helpers/audio_helper.dart';
=======
import 'package:location/location.dart';
>>>>>>> d1d98221d2e03bb17ad84a1b1cb007cc33cc0ad5
import 'package:survivalrunner/views/map/map_viewmodel.dart';


class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _mapController = Completer();
  Location _location;
  LocationData currentLocation;
  StreamSubscription _locationSubscription;

  @override
  void initState() {
    super.initState();

    _location = new Location();

    _locationSubscription = _location.onLocationChanged.listen((currLoc) {

        setState(() {
          currentLocation = currLoc;
        });

        print (currentLocation);
      });
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
            // Gets the audio helper from the service locator and plays the audio.
            GetIt.instance<AudioHelper>().playRandomFollowerAudio();
            return snapshot.hasData
                ? GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    initialCameraPosition:
                        context.watch<MapViewModel>().initialCameraPosition,
                    markers: {
                      Marker(
                        markerId: MarkerId('ffa'),
                        position: LatLng(currentLocation.latitude, currentLocation.longitude),
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
