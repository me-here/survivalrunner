import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:survivalrunner/views/map/map_viewmodel.dart';

class MapView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(),
      builder: (context, child) {
        return FutureBuilder(
          future: context.watch<MapViewModel>().getInitialCameraPosition(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? GoogleMap(
                    initialCameraPosition: snapshot.data,
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
