import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps with ChangeNotifier {
  final Completer<GoogleMapController> _completer =
      Completer<GoogleMapController>();

  static const DEFAULT_POSITION = LatLng(5.573447631959232, 95.354061037181);
  static const DEFAULT_ZOOM = 18.0;

  Set<Marker> _markers = Set<Marker>();
  CameraPosition _currentLocation = CameraPosition(
    target: DEFAULT_POSITION,
    zoom: DEFAULT_ZOOM,
  );
  CameraPosition _myLocation = CameraPosition(
    target: DEFAULT_POSITION,
    zoom: DEFAULT_ZOOM,
  );
  bool _loading = false;

  Completer<GoogleMapController> get completer => _completer;
  Set<Marker> get markers => _markers;
  CameraPosition get currentLocation => _currentLocation;
  CameraPosition get myLocation => _myLocation;
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
    _myLocation = currentLocation;
    notifyListeners();
    setMarkers(
      LatLng(currentPosition.latitude, currentPosition.longitude),
      'myLocation',
    );
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

  void setMarkers(LatLng position, String markerId) {
    _markers.add(
      Marker(
        markerId: MarkerId(markerId),
        position: position,
      ),
    );
    notifyListeners();
  }

  void animateCamera(CameraPosition _camPosition) async {
    final GoogleMapController controller = await _completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_camPosition));
    _currentLocation = _camPosition;
    notifyListeners();
  }

  void setCurrentLocation(CameraPosition _camPosition) async {
    _currentLocation = _camPosition;
    notifyListeners();
  }
}
