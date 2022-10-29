import 'package:flutter/material.dart';
import 'package:tempo_template/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tempo_template/services/location.dart';

 class Location {
  late double latitute;
  late double longitude;
}

  void checkLocationPermission() {

  }

  void  getCurrentLocation() async {

    try {

      late double latitude;
      late double longitude;

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }

}