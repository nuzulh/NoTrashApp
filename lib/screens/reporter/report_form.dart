import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';
import 'package:no_trash/providers/report.dart';
import 'package:no_trash/widgets/header.dart';
import 'package:no_trash/widgets/inline_text.dart';
import 'package:no_trash/widgets/layout.dart';
import 'package:no_trash/widgets/loading.dart';
import 'package:no_trash/widgets/primary_button.dart';
import 'package:no_trash/widgets/secondary_button.dart';
import 'package:no_trash/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:no_trash/screens/reporter/location_picker.dart';

class ReportForm extends StatelessWidget {
  const ReportForm({super.key});
  static const routeName = 'report-form';

  @override
  Widget build(BuildContext context) {
    final report = Provider.of<Report>(context);

    return Scaffold(
      backgroundColor: kBgColor,
      body: Layout(
        header: Header(
          label: 'Buat laporan',
          icon: Icons.post_add_rounded,
          onBack: () => report.resetForm(),
        ),
        child: Column(
          children: [
            TextInput(
              label: 'Alamat',
              hintText: 'alamat lengkap lokasi tumpukan sampah',
              controller: report.address,
              maxLines: 4,
            ),
            TextInput(
              label: 'Catatan',
              hintText: 'sampah sudah membusuk...',
              controller: report.notes,
              maxLines: 4,
            ),
            report.tempFilePath.isEmpty
                ? SecondaryButton(
                    label: 'Unggah foto',
                    icon: Icons.add_a_photo_outlined,
                    onPressed: () {
                      report.uploadTempFile(context);
                    },
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Foto',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          File(report.tempFilePath),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 146,
                        ),
                      ),
                    ],
                  ),
            report.map.isEmpty
                ? PrimaryButton(
                    label: 'Pilih lokasi',
                    icon: Icons.location_on,
                    onPressed: () =>
                        Navigator.pushNamed(context, LocationPicker.routeName),
                  )
                : InlineText(label: 'Titik Koordinat', value: report.map),
            const Divider(color: Colors.black54, height: 60),
            report.loading
                ? const Loading()
                : PrimaryButton(
                    label: 'Submit',
                    onPressed: () {
                      report.addReport(context);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
