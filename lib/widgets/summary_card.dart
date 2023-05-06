import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class SummaryCard extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double height;
  final String? value;
  final IconData? icon;

  const SummaryCard({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 118,
    this.value,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(2, 4),
            ),
          ],
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(3, 8),
            stops: [0.1, 1],
            colors: [kPrimaryColor, kBgColor],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            icon != null
                ? Icon(icon, color: Colors.white)
                : Text(
                    value ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 52,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
