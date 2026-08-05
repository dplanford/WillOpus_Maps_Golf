import 'package:google_maps_flutter/google_maps_flutter.dart';

class WillOpusMapPoint {
  final LatLng latlng;
  final double bearing;
  final double tilt;
  final double zoom;

  const WillOpusMapPoint({
    this.latlng = const LatLng(0.0, 0.0),
    this.bearing = 0.0,
    this.tilt = 0.0,
    this.zoom = 10.0,
  });
}
