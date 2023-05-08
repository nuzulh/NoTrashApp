import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PromptDialog extends StatelessWidget {
  final String text;
  final String approveLabel;
  final String rejectLabel;
  final Function() onApprove;
  final Function() onReject;

  const PromptDialog({
    super.key,
    required this.text,
    required this.approveLabel,
    required this.rejectLabel,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Icon(
        Icons.question_mark_rounded,
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
          onPressed: onApprove,
          child: Text(
            approveLabel,
            style: GoogleFonts.poppins(
              color: Colors.greenAccent[700],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        TextButton(
          onPressed: onReject,
          child: Text(
            rejectLabel,
            style: GoogleFonts.poppins(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
