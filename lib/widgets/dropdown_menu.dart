import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:no_trash/helpers/consts.dart';

class CustomDropdownMenu extends StatelessWidget {
  final String hintText;
  final List items;
  final Function(String value) onChanged;

  const CustomDropdownMenu({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: DropdownButtonFormField2(
        isExpanded: true,
        hint: Text(
          hintText,
          style: GoogleFonts.poppins(fontSize: 14),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: kPrimaryColor,
        ),
        buttonHeight: 22,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                ),
              ),
            )
            .toList(),
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: kPrimaryColor,
        ),
        onChanged: (value) {
          onChanged(value.toString());
        },
      ),
    );
  }
}
