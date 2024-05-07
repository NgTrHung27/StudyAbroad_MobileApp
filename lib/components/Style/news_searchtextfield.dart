import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsSearchTextField extends StatelessWidget {
  final String hintText;

  const NewsSearchTextField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.getFont(
        'Montserrat',
        color: const Color(0xff7D1F1F),
        fontSize: 19.0,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xff7D1F1F), width: 1.0,),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 0.0),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.getFont(
          'Montserrat',
          color: const Color(0xff7D1F1F).withOpacity(0.6),
          fontSize: 19.0,
          fontWeight: FontWeight.w500
        ),
        prefixIcon: const Icon(Icons.search, color: Color(0xff7D1F1F), size: 30.0,),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
    );
  }
}