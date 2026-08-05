import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:willopus_golf_maps/models/willopus_map_point.dart';

const WillOpusMapPoint courseLosAltosPar3Init = WillOpusMapPoint(
  latlng: LatLng(0.0, 0.0),
  bearing: 0.0,
  tilt: 0.0,
  zoom: 10.0,
);

// TODO: actual hole locations!
// TODO: the rest of the holes!
const List<WillOpusMapPoint> courseLosAltosPar3 = [
  WillOpusMapPoint(
    latlng: LatLng(35.08431862765509, -106.53903907564677),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 20.0,
  ),
  WillOpusMapPoint(
    latlng: LatLng(35.08466419316038, -106.54106009346265),
    bearing: 90.0,
    tilt: 0.0,
    zoom: 20.0,
  ),
  WillOpusMapPoint(
    latlng: LatLng(35.08280951429785, -106.54206323963372),
    bearing: 0.0,
    tilt: 0.0,
    zoom: 20.0,
  ),
];

// TODO: add other rotation set of holes?

// TMP!
const List<LatLng> tmpPoints = [
  LatLng(35.084509, -106.539280),
  LatLng(35.083964, -106.540561),
];
