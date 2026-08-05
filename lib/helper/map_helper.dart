import 'dart:math';

import 'package:willopus_golf_maps/data/los_altos_par3.dart';
import 'package:willopus_golf_maps/helper/math_helper.dart';
import 'package:willopus_golf_maps/models/willopus_map_point_simple.dart';

class MapHelper {
  static double getZoomFromScreenAndSpan(double screenSize, double degreeSpan) {
    final mapZoom = MathHelper.log2((screenSize * 360.0) / (degreeSpan * 256.0));
    // TODO: floor to int before constraining between 0 & 21? Return int?
    return max(0.0, min(mapZoom, 21.0));
  }

  static WillOpusMapPointSimple getCenter(WillOpusMapPointSimple p1, WillOpusMapPointSimple p2) {
    return WillOpusMapPointSimple(
      lat: MathHelper.avrg(p1.lat, p2.lat),
      lng: MathHelper.avrg(p1.lng, p2.lng),
    );
  }

  // TODO: Tmp for testing!
  static double getTmpDegreeSpan() {
    return (tmpPoints[0].lng - tmpPoints[1].lng).abs();
  }
}
