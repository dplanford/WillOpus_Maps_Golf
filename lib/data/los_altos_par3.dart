import 'package:willopus_golf_maps/models/willopus_map_point.dart';
import 'package:willopus_golf_maps/models/willopus_map_point_simple.dart';

const WillOpusMapPoint courseLosAltosPar3Init = WillOpusMapPoint(lat: 0.0, lng: 0.0, bearing: 0.0, tilt: 0.0, zoom: 10.0);

// TODO: actual hole locations!
// TODO: the rest of the holes!
const List<WillOpusMapPoint> courseLosAltosPar3 = [
  WillOpusMapPoint(lat: 35.08431862765509, lng: -106.53903907564677, bearing: 0.0, tilt: 0.0, zoom: 20.0),
  WillOpusMapPoint(lat: 35.08466419316038, lng: -106.54106009346265, bearing: 90.0, tilt: 0.0, zoom: 20.0),
  WillOpusMapPoint(lat: 35.08280951429785, lng: -106.54206323963372, bearing: 0.0, tilt: 0.0, zoom: 20.0),
];

// TODO: add other rotation set of holes?

// TMP!
const List<WillOpusMapPointSimple> tmpPoints = [
  WillOpusMapPointSimple(lat: 35.084509, lng: -106.539280),
  WillOpusMapPointSimple(lat: 35.083964, lng: -106.540561),
];
