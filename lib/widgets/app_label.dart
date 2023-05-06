import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class AppLabel extends StatelessWidget {
  const AppLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'No',
          style: GoogleFonts.poppins(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
        Text(
          'Trash',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ],
    );
  }
}
