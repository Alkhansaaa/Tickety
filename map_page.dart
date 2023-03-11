import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController _mapController;
  bool isReady = false;
  @override
  void initState() {
    _mapController = MapController(
        initMapWithUserPosition: false,
        initPosition: GeoPoint(latitude: 23.9758367, longitude: 36.0398296));

    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: isReady
          ? FloatingActionButton(
              child: const Text('Select'),
              onPressed: () {
                _mapController
                    .getCurrentPositionAdvancedPositionPicker()
                    .then((value) {
                  Navigator.pop(context, value);
                });
              },
            )
          : null,
      body: OSMFlutter(
        controller: _mapController,
        initZoom: 7,
        showZoomController: true,
        markerOption: MarkerOption(
            advancedPickerMarker: const MarkerIcon(
          icon: Icon(Icons.my_location, size: 90, color: Colors.red),
        )),
        onGeoPointClicked: (p0) {
          log('CLICKED $p0');
        },
        isPicker: true,
        onMapIsReady: (p0) {
          setState(() {
            isReady = p0;
          });
        },
        mapIsLoading: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
