import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class TextMonserats extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLine;
  final TextAlign? textAlign;

  const TextMonserats(this.text,
      {super.key,
      this.color,
      this.fontWeight,
      this.fontSize,
      this.maxLine,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Montserrat',
        color: color ?? AppColor.redButton,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 14,
      ),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
