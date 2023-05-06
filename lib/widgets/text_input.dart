import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatelessWidget {
  final bool? isPassword;
  final TextInputType? textInputType;
  final String? suffixText;
  final String? label;
  final String hintText;
  final TextEditingController controller;
  final int maxLines;

  const TextInput({
    super.key,
    this.isPassword,
    this.textInputType,
    this.suffixText,
    this.maxLines = 1,
    this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label != null
              ? Text(
                  label!,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : SizedBox.shrink(),
          TextField(
            controller: controller,
            obscureText: isPassword == true ? true : false,
            keyboardType: textInputType ?? TextInputType.text,
            maxLines: maxLines,
            style: GoogleFonts.poppins(fontSize: 14),
            decoration: InputDecoration(
              prefixText: suffixText ?? '',
              hintText: hintText,
              hintStyle: GoogleFonts.poppins(
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          )
        ],
      ),
    );
  }
}
