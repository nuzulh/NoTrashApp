import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps with ChangeNotifier {
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  Set<Marker> _markers = Set<Marker>();
  CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(5.573447631959232, 95.354061037181),
    zoom: 18,
  );
  bool _loading = false;

  Completer<GoogleMapController> get completer => _completer;
  Set<Marker> get markers => _markers;
  CameraPosition get cameraPosition => _cameraPosition;
  bool get loading => _loading;

  void startLoading() {
    _loading = true;
    notifyListeners();
  }

  void stopLoading() {
    _loading = false;
    notifyListeners();
  }

  void onStart() async {
    startLoading();
    Position currentPosition = await getGeoLocationPosition();
    setMarkers(LatLng(currentPosition.latitude, currentPosition.longitude));
    animateCamera(CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 18,
    ));
    stopLoading();
  }

  Future<Position> getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Layanan lokasi tidak nyala');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Layanan lokasi tidak diizinkan');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Layanan lokasi tidak diizinkan selamanya, kami tidak dapat mengaksesnya',
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  void setMarkers(LatLng position) {
    _markers.add(
      Marker(
        markerId: MarkerId('marker'),
        position: position,
      ),
    );
    notifyListeners();
  }

  void animateCamera(CameraPosition _camPosition) async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_camPosition));
    _cameraPosition = _camPosition;
    notifyListeners();
  }
}
