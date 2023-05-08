import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InlineText extends StatelessWidget {
  final String label;
  final String? value;
  final bool isNewLine;
  final Color? color;
  final Widget? child;

  const InlineText({
    super.key,
    required this.label,
    this.value,
    this.isNewLine = false,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return isNewLine
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: color ?? Colors.black,
                  ),
                ),
                Text(
                  value ?? '',
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: color ?? Colors.black87,
                  ),
                ),
              ],
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: color ?? Colors.black,
                ),
              ),
              child != null
                  ? child!
                  : Flexible(
                      child: Text(
                        value ?? '',
                        textAlign: TextAlign.right,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: color ?? Colors.black87,
                        ),
                      ),
                    ),
            ],
          );
  }
}
