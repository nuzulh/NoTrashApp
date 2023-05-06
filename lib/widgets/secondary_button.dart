import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          foregroundColor: kPrimaryColor,
          side: const BorderSide(color: kPrimaryColor, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(icon),
                  )
                : const SizedBox.shrink(),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
