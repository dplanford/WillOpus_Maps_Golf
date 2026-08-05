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
              target: LatLng(courseLosAltosPar3Init.lat, courseLosAltosPar3Init.lng),
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
                _animateCamera(courseLosAltosPar3[0]);
              },
              child: const Text('Hole 1'),
            ),
            TextButton(
              onPressed: () {
                _animateCamera(courseLosAltosPar3[1]);
              },
              child: const Text('Hole 2'),
            ),
            TextButton(
              onPressed: () {
                //_animateCamera(courseLosAltosPar3[2]);
                final screenWidth = MediaQuery.of(context).size.width;
                final degreeSpan = MapHelper.getTmpDegreeSpan();
                final mapZoom = MapHelper.getZoomFromScreenAndSpan(screenWidth, degreeSpan);

                final centerPoint = MapHelper.getCenter(tmpPoints[0], tmpPoints[1]);

                _animateCamera(WillOpusMapPoint(lat: centerPoint.lat, lng: centerPoint.lng, zoom: mapZoom));
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
      CameraUpdate.newCameraPosition(CameraPosition(bearing: mapPoint.bearing, target: LatLng(mapPoint.lat, mapPoint.lng), tilt: mapPoint.tilt, zoom: mapPoint.zoom)),
      duration: _cameraUpdateAnimationDuration,
    );
  }
}
