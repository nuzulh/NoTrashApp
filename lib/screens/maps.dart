import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:no_trash/providers/maps.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:provider/provider.dart';

class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});
  static const routeName = 'location-picker';

  @override
  Widget build(BuildContext context) {
    final maps = Provider.of<Maps>(context, listen: false);
    final report = Provider.of<Report>(context, listen: false);
    Future.delayed(Duration(milliseconds: 100)).then((_) {
      maps.onStart();
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(label: 'Pilih Lokasi', icon: Icons.map_sharp),
            Expanded(
              child: Consumer<Maps>(
                builder: (context, value, child) => Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: value.cameraPosition,
                      markers: value.markers,
                      onMapCreated: (GoogleMapController controller) {
                        try {
                          value.completer.complete(controller);
                        } catch (_) {}
                      },
                    ),
                    value.loading
                        ? Container(
                            color: Colors.black38,
                            child: Loading(),
                          )
                        : SizedBox.shrink(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 80,
                        vertical: 20,
                      ),
                      child: PrimaryButton(
                        label: 'Pilih',
                        onPressed: () {
                          if (!value.loading) {
                            report.setMap(value.cameraPosition.target.latitude
                                    .toString() +
                                ', ' +
                                value.cameraPosition.target.longitude
                                    .toString());
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
