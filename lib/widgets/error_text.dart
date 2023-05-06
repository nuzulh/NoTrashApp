import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorText extends StatelessWidget {
  final String text;

  const ErrorText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.red,
        fontSize: 12,
      ),
    );
  }
}
