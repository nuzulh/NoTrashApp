import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/primary_button.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});
  static const routeName = 'location-view';

  @override
  Widget build(BuildContext context) {
    final Completer<GoogleMapController> completer =
        Completer<GoogleMapController>();
    final cameraPosition =
        ModalRoute.of(context)!.settings.arguments as CameraPosition;
    print(cameraPosition);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(label: 'Lokasi Sampah', icon: Icons.map_sharp),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: cameraPosition,
                    markers: {
                      Marker(
                        markerId: MarkerId('trashLocation'),
                        position: cameraPosition.target,
                      ),
                    },
                    myLocationButtonEnabled: true,
                    zoomGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      try {
                        completer.complete(controller);
                      } catch (_) {}
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 80,
                      vertical: 20,
                    ),
                    child: PrimaryButton(
                      label: 'Lihat di Google Maps',
                      onPressed: () async {
                        try {
                          await MapsLauncher.launchCoordinates(
                            cameraPosition.target.latitude,
                            cameraPosition.target.longitude,
                          );
                        } catch (err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: const [
                                  Icon(
                                    Icons.warning_rounded,
                                    color: Colors.white,
                                  ),
                                  Text(' Gagal membuka Google Maps'),
                                ],
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
