import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/models/information.dart';
import 'package:url_launcher/url_launcher.dart';

class InformationCard extends StatelessWidget {
  final InformationModel information;
  const InformationCard({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width - 80,
      margin: const EdgeInsets.only(right: 16, bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
          final Uri url = Uri.parse(information.url);
          if (await canLaunchUrl(url)) {
            launchUrl(url);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.warning_rounded,
                      color: Colors.white,
                    ),
                    Text(' Gagal meluncurkan Browser'),
                  ],
                ),
              ),
            );
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Container(
                width: double.infinity,
                height: 160,
                child: Image.asset(
                  information.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                information.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
