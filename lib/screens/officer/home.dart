import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/report_card.dart';
import 'package:provider/provider.dart';

class OfficerHome extends StatelessWidget {
  const OfficerHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final report = Provider.of<Report>(context, listen: false);

    Future.delayed(const Duration(milliseconds: 100)).then((_) {
      auth.onStart();
      report.onStart();
    });

    return Layout(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Consumer<Auth>(
              builder: (context, value, child) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Halo, ${value.currentUser.name} ',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Badge(
                    label: Text(
                      value.currentUser.role,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                    backgroundColor: Colors.brown,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            child: Image.asset('assets/images/officer.png'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.date_range_outlined),
              Text(
                ' Sabtu, 25-02-2023 16:11',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'Jumlah poin Anda: ',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.monetization_on,
                color: kPrimaryColor,
                size: 36,
                shadows: [
                  Shadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              Consumer<Report>(
                builder: (context, value, child) => Text(
                  ' ${value.poins}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w900,
                    fontSize: 48,
                    color: kPrimaryColor,
                    shadows: [
                      const Shadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 30,
            child: Text(
              'Laporan terkini',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Consumer<Report>(
                builder: (context, value, child) => Row(
                  children: value.unconfirmedReports
                      .map((report) => ReportCard(report: report))
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
