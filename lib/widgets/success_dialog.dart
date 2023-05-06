import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class SuccessDialog extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final Function() onAction;

  const SuccessDialog({
    super.key,
    required this.text,
    required this.buttonLabel,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        Icons.check_circle_outline_rounded,
        size: 54,
        color: Colors.greenAccent[700],
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(fontSize: 14),
      ),
      actions: [
        TextButton(
          onPressed: onAction,
          child: Text(
            buttonLabel,
            style: GoogleFonts.poppins(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
