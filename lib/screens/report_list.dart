import 'package:flutter/material.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/helpers/utils.dart';
import 'package:no_trash/models/report.dart';
import 'package:no_trash/screens/report_detail.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/summary_card.dart';

class ReportList extends StatelessWidget {
  const ReportList({super.key});
  static const routeName = 'report-list';

  @override
  Widget build(BuildContext context) {
    final reports =
        ModalRoute.of(context)!.settings.arguments as List<ReportModel>;

    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        header: const Header(
          label: 'Daftar Laporan',
          icon: Icons.list_alt_rounded,
        ),
        child: Column(
          children: [
            Column(
              children: reports
                  .map((report) => SummaryCard(
                        label: formattedDate(report.reportedDate),
                        height: 68,
                        icon: report.confirmed
                            ? Icons.check_circle
                            : Icons.pending_actions_rounded,
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            ReportDetail.routeName,
                            arguments: report,
                          );
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
