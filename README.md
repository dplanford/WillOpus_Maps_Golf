# willopus_golf_maps

So far, this is a quick test of playing with Google Maps in a Flutter project. Eventually it might become a simple golf mapping app, showing each hole and your position as you play a round, as well as keeping your score.

It currently displays a Google Maps view, and 3 buttons (Zoom 1-3). Clicking a button zooms to 3 locations on the Albuquerque Los Altos Golf Course, with the third button running extra calculations to match the map zoom to the device's screen size.

## Getting Started

This repository only includes the Flutter files (lib/ directory, pubspec.yaml, etc.). The platform specific build files are not included.

To play with this code, first create a new Flutter project (aka: flutter create willopus_maps_golf).

Second, copy the included files into the main directory, overwritting any existing just created files.

Third, on pub.dev, look up the google_maps_flutter package, and follow the simple instructions to create your own Google key, and inject it into the platform build settings.

Now you can play with my example code!
