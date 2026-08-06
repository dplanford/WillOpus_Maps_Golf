import 'dart:math';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:willopus_golf_maps/data/los_altos_par3.dart';
import 'package:willopus_golf_maps/helper/math_helper.dart';
import 'package:willopus_golf_maps/models/willopus_map_point.dart';

class MapHelper {
  static LatLng getLineCenter(LatLng p1, LatLng p2) {
    return LatLng(
      MathHelper.avrg(p1.latitude, p2.latitude),
      MathHelper.avrg(p1.longitude, p2.longitude),
    );
  }

  static WillOpusMapPoint getRotatedPointFromBoundingList({
    required List<LatLng> mapPoints,
    required Size screenSize,
    double bearing = 0.0,
  }) {
    const GOOGLE_ZOOM_ZERO_TILE_SIZE = 256.0;

    // Convert a Lat/Lng to Mercator pixels at zoom 0.
    Point latlngToTilePoint(LatLng latlng) {
      final x = GOOGLE_ZOOM_ZERO_TILE_SIZE * (latlng.longitude + 180.0) / 360.0;
      final sineOfLat = sin(latlng.latitude * pi / 180.0);
      final y = GOOGLE_ZOOM_ZERO_TILE_SIZE * (0.5 - log((1.0 + sineOfLat) / (1.0 - sineOfLat)) / (4.0 * pi));
      return Point(x, y);
    }

    // Convert the list of map points to tile points
    final List<Point> tilePoints = mapPoints.map((p) => latlngToTilePoint(p)).toList();

    // Find the center of the bounding box of pixel points.
    final sumTilePoints = tilePoints.reduce((sum, p) => sum + p);
    final centerTilePoint = Point(sumTilePoints.x / tilePoints.length, sumTilePoints.y / tilePoints.length);

    // Rotate around the center point by negative bearing
    final angleRad = -bearing * pi / 180.0;
    final cosBearing = cos(angleRad);
    final sinBearing = sin(angleRad);

    var minX = double.infinity;
    var maxX = double.negativeInfinity;
    var minY = double.infinity;
    var maxY = double.negativeInfinity;

    tilePoints.forEach((p) {
      // offset to center
      final relX = p.x - centerTilePoint.x;
      final relY = p.x - centerTilePoint.y;

      // rotate
      final rotX = (relX * cosBearing) - (relY * sinBearing);
      final rotY = (relX * sinBearing) + (relY * cosBearing);

      // build boundies as we iterate through the list
      if (rotX < minX) minX = rotX;
      if (rotX > maxX) maxX = rotX;
      if (rotY < minY) minY = rotY;
      if (rotY > maxY) maxY = rotY;
    });

    final boundingSize = Size(maxX - minX, maxY - minY);

    // TODO: Add padding here, if desired... see notes on this.

    // calculate zoom, based on Mercator scaling property: pizelSize = sizeAtZoom0 * 2^zoom
    final zoomX = MathHelper.log2(screenSize.width / boundingSize.width);
    final zoomY = MathHelper.log2(screenSize.height / boundingSize.height);

    // TODO: need this?
    // restrict zoom to prevent screen edge clipping, and clamped to positive values
    //final zoom = max(0.0, min(zoomX, zoomY));
    final zoom = zoomY;

    // Find the center of the bounding box of pixel points.
    double sumMapPointLat = 0.0;
    double sumMapPointLng = 0.0;
    mapPoints.forEach((p) {
      sumMapPointLat += p.latitude;
      sumMapPointLng += p.longitude;
    });
    final centerMapPoint = LatLng(
      sumMapPointLat / mapPoints.length,
      sumMapPointLng / mapPoints.length,
    );

    return WillOpusMapPoint(latlng: centerMapPoint, bearing: bearing, zoom: zoom);
  }

  static double getZoomFromScreenAndSpan(double screenSize, double degreeSpan) {
    final mapZoom = MathHelper.log2((screenSize * 360.0) / (degreeSpan * 256.0));
    return max(0.0, min(mapZoom, 21.0));
  }

  // TODO: Tmp for testing!
  static double getTmpDegreeSpan() {
    return (tmpPoints[0].longitude - tmpPoints[1].longitude).abs();
  }
}
