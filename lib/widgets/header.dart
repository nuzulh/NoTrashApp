import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class Header extends StatelessWidget {
  final String label;
  final IconData icon;

  const Header({
    super.key,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left,
                size: 32,
                color: Colors.white,
              ),
            ),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Icon(icon, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
