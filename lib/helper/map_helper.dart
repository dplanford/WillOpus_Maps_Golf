import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:willopus_golf_maps/data/los_altos_par3.dart';
import 'package:willopus_golf_maps/helper/math_helper.dart';

class MapHelper {
  static double getZoomFromScreenAndSpan(double screenSize, double degreeSpan) {
    final mapZoom = MathHelper.log2((screenSize * 360.0) / (degreeSpan * 256.0));
    // TODO: floor to int before constraining between 0 & 21? Return int?
    return max(0.0, min(mapZoom, 21.0));
  }

  static LatLng getCenter(LatLng p1, LatLng p2) {
    return LatLng(
      MathHelper.avrg(p1.latitude, p2.latitude),
      MathHelper.avrg(p1.longitude, p2.longitude),
    );
  }

  // TODO: Tmp for testing!
  static double getTmpDegreeSpan() {
    return (tmpPoints[0].longitude - tmpPoints[1].longitude).abs();
  }
}
