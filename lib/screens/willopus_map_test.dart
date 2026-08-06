import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:willopus_golf_maps/models/willopus_map_point.dart';
import 'package:willopus_golf_maps/data/los_altos_par3.dart';
import 'package:willopus_golf_maps/helper/map_helper.dart';

class WillOpusMapTestBody extends StatelessWidget {
  const WillOpusMapTestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Golf Maps Test')),
      body: WillOpusMapTest(),
    );
  }
}

class WillOpusMapTest extends StatefulWidget {
  const WillOpusMapTest({super.key});

  @override
  State createState() => WillOpusMapTestState();
}

class WillOpusMapTestState extends State<WillOpusMapTest> {
  GoogleMapController? _mapController;
  Duration? _cameraUpdateAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: GoogleMap(
            onMapCreated: (controller) {
              _mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(courseLosAltosPar3Init.latlng.latitude, courseLosAltosPar3Init.latlng.longitude),
            ),
            // TODO: can I add bearing/tilt/zoom to init position?
            // Otherwise, need to quick update after init? Without animating!
            mapType: MapType.satellite,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                _animateCamera(
                  MapHelper.getRotatedPointFromBoundingList(
                    mapPoints: hole1Points,
                    screenSize: MediaQuery.of(context).size,
                    bearing: 0.0,
                  ),
                );
              },
              child: const Text('Hole 1'),
            ),
            TextButton(
              onPressed: () {
                _animateCamera(
                  MapHelper.getRotatedPointFromBoundingList(
                    mapPoints: hole1Points,
                    screenSize: MediaQuery.of(context).size,
                    bearing: 90.0,
                  ),
                );
              },
              child: const Text('Hole 2'),
            ),
            TextButton(
              onPressed: () {
                _animateCamera(
                  MapHelper.getRotatedPointFromBoundingList(
                    mapPoints: hole1Points,
                    screenSize: MediaQuery.of(context).size,
                    bearing: 245.0,
                  ),
                );
              },
              child: const Text('Hole 3'),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  void _animateCamera(WillOpusMapPoint mapPoint) {
    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: mapPoint.bearing,
          target: LatLng(mapPoint.latlng.latitude, mapPoint.latlng.longitude),
          tilt: mapPoint.tilt,
          zoom: mapPoint.zoom,
        ),
      ),
      duration: _cameraUpdateAnimationDuration,
    );
  }
}
