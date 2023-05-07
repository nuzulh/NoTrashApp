import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/helpers/utils.dart';
import 'package:no_trash/models/report.dart';
import 'package:no_trash/models/user.dart';
import 'package:no_trash/providers/auth.dart';
import 'package:no_trash/screens/report_detail.dart';
import 'package:no_trash/widgets/loading.dart';

class ReportCard extends StatelessWidget {
  final ReportModel report;
  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          ReportDetail.routeName,
          arguments: report,
        );
      },
      child: Container(
        width: 152,
        height: 198,
        margin: const EdgeInsets.only(right: 10, bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(2, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(1, 6),
            stops: [0.1, 1],
            colors: [kPrimaryColor, kBgColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.library_books, color: Colors.white),
                  const SizedBox(width: 10),
                  Flexible(
                    child: FutureBuilder<UserModel>(
                      future: Auth().getUserById(report.reporter.id),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.name,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                Auth().countryCode + snapshot.data!.phoneNumber,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                formattedDate(report.reportedDate),
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Loading();
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const Icon(Icons.location_on_sharp, color: Colors.white),
                    Text(
                      report.address,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
