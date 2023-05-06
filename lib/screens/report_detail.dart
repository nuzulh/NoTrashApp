import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/helpers/utils.dart';
import 'package:no_trash/models/report.dart';
import 'package:no_trash/models/user.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/screens/officer/location.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/inline_text.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/secondary_button.dart';
import 'package:provider/provider.dart';

class ReportDetail extends StatelessWidget {
  const ReportDetail({super.key});
  static const routeName = 'report-detail';

  @override
  Widget build(BuildContext context) {
    final report = ModalRoute.of(context)!.settings.arguments as ReportModel;
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        header: const Header(
          label: 'Rincian Laporan',
          icon: Icons.library_books_outlined,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<UserModel>(
              future: Auth().getUserById(report.reporter.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      InlineText(
                        label: 'Pelapor',
                        value: snapshot.data!.name,
                      ),
                      InlineText(
                        label: 'No. HP',
                        value: auth.countryCode + snapshot.data!.phoneNumber,
                      ),
                    ],
                  );
                } else {
                  return const Loading();
                }
              },
            ),
            InlineText(
              label: 'Waktu',
              value: formattedDateTime(report.reportedDate),
            ),
            InlineText(
              label: 'Catatan',
              value: report.notes,
              isNewLine: true,
            ),
            Text(
              "Foto",
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FutureBuilder<String>(
                future: Report().downloadURL(report.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return snapshot.data!.isNotEmpty
                        ? Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 227,
                          )
                        : const Placeholder(fallbackHeight: 227);
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      !snapshot.hasData) {
                    return const Loading();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            InlineText(
              label: 'Alamat',
              value: report.address,
              isNewLine: true,
            ),
            auth.currentUser.role == 'Pelapor'
                ? Column(
                    children: [
                      InlineText(
                        label: 'Status',
                        value: report.confirmed
                            ? 'Sudah dikonfirmasi'
                            : 'Belum dikonfirmasi',
                        color:
                            report.confirmed ? Colors.green : Colors.redAccent,
                      ),
                      report.confirmed
                          ? FutureBuilder<UserModel>(
                              future: Auth().getUserById(
                                report.confirmedBy!.id,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      InlineText(
                                        label: 'Dikonfirmasi oleh',
                                        value: snapshot.data!.name,
                                      ),
                                      InlineText(
                                        label: 'Dikonfirmasi pada',
                                        value: formattedDateTime(
                                          report.confirmedDate ??
                                              Timestamp.now(),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return const Loading();
                                }
                              },
                            )
                          : const SizedBox.shrink()
                    ],
                  )
                : const SizedBox.shrink(),
            SecondaryButton(
              label: 'Lihat lokasi',
              icon: Icons.location_on,
              onPressed: () {
                try {
                  final double latitude =
                      double.parse(report.map.split(', ')[0]);
                  final double longitude =
                      double.parse(report.map.split(', ')[1]);

                  Navigator.pushNamed(
                    context,
                    LocationView.routeName,
                    arguments: CameraPosition(
                      target: LatLng(latitude, longitude),
                      zoom: 18.0,
                    ),
                  );
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: const [
                          Icon(Icons.warning_rounded, color: Colors.white),
                          Text(' Lokasi sampah tidak tersedia'),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            auth.currentUser.role == 'Petugas' && !report.confirmed
                ? Consumer<Report>(
                    builder: (context, value, child) => value.loading
                        ? const Loading()
                        : PrimaryButton(
                            label: 'Konfirmasi',
                            onPressed: () {
                              value.confirmReport(context, report.id);
                            },
                          ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
