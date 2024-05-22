import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class NewsSearchTextField extends StatelessWidget {
  final String hintText;

  const NewsSearchTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.getFont(
        'Montserrat',
        color: AppColor.redButton,
        fontSize: 19.0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.redButton,
            width: 1.0,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont('Montserrat',
            color: AppColor.redButton.withOpacity(0.6),
            fontSize: 19.0,
            fontWeight: FontWeight.w500),
        prefixIcon: Icon(
          Icons.search,
          color: AppColor.redButton,
          size: 30.0,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}
