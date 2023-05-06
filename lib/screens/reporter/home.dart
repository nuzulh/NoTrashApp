import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/screens/reporter/report_form.dart';
import 'package:no_trash/screens/report_list.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/summary_card.dart';
import 'package:provider/provider.dart';

class ReporterHome extends StatelessWidget {
  const ReporterHome({super.key});

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
                    backgroundColor: Colors.teal,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
            child: Image.asset('assets/images/reporter.png'),
          ),
          Consumer<Report>(
            builder: (context, value, child) => Column(
              children: [
                SummaryCard(
                  label: 'Laporan\nsemua',
                  value: value.myReports.length.toString(),
                  onPressed: () {
                    Navigator.pushNamed(context, ReportList.routeName,
                        arguments: value.myReports);
                  },
                ),
                SummaryCard(
                  label: 'Laporan\ndikonfirmasi',
                  value: value.myConfirmedReports.length.toString(),
                  onPressed: () {
                    Navigator.pushNamed(context, ReportList.routeName,
                        arguments: value.myConfirmedReports);
                  },
                ),
              ],
            ),
          ),
          const Divider(color: Colors.black54, height: 30),
          PrimaryButton(
            label: 'Lapor sekarang',
            icon: Icons.report_gmailerrorred,
            onPressed: () {
              Navigator.pushNamed(context, ReportForm.routeName);
            },
          ),
        ],
      ),
    );
  }
}
