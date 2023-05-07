import 'package:flutter/material.dart';
import 'package:no_trash/helpers/utils.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/screens/report_detail.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/screen_label.dart';
import 'package:no_trash/widgets/summary_card.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Report>(context, listen: false);

    Future.delayed(Duration(milliseconds: 100)).then((_) {
      report.onStart();
    });

    return Layout(
      child: Column(
        children: [
          ScreenLabel(icon: Icons.history_sharp, label: 'Riwayat'),
          Consumer<Report>(
            builder: (context, value, child) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: value.myHistoryReports.length,
              itemBuilder: (context, index) => SummaryCard(
                byLabel: 'Dikonfirmasi pada',
                label: formattedDate(
                  value.myHistoryReports[index].confirmedDate!,
                ),
                height: 68,
                icon: value.myHistoryReports[index].confirmed
                    ? Icons.check_circle
                    : Icons.pending_actions_rounded,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    ReportDetail.routeName,
                    arguments: value.myHistoryReports[index],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
