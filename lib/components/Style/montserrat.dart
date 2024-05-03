import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextMonserats extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize; // Add this line

  const TextMonserats(this.text, {super.key, this.color, this.fontWeight, this.fontSize}); 

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Montserrat',
        color: color ?? const Color(0xff7D1F1F),
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 14,
      ),
    );
  }
}