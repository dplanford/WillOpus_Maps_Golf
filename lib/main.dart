// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

import 'screens/willopus_map_test.dart';

// TODO: Need this?
/// Place your map ID here. Map ID is required for pages that use advanced
/// markers.
//const String? _mapId = null;

/// MapsDemo is the Main Application.
class WillOpusGolfMaps extends StatelessWidget {
  /// Default Constructor
  const WillOpusGolfMaps({super.key});

  @override
  Widget build(BuildContext context) {
    return WillOpusMapTestBody();
  }
}

void main() {
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    initializeAndroidMapRenderer();
  }

  runApp(const MaterialApp(home: WillOpusGolfMaps()));
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;

/// Initializes map renderer to the `latest` renderer type for Android platform.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeAndroidMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final completer = Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  WidgetsFlutterBinding.ensureInitialized();

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    unawaited(
      mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest).then(
            (AndroidMapRenderer initializedRenderer) => completer.complete(initializedRenderer),
          ),
    );
  } else {
    completer.complete(null);
  }

  return completer.future;
}
