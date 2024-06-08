import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';

class TextMonserats extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final int? maxLine;
  final TextAlign? textAlign;
  final double height;

  const TextMonserats(
    this.text, {
    super.key,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.maxLine,
    this.textAlign,
    this.height = 1.75, // Initialize with default value
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Montserrat',
        color: color ?? textColor,
        fontWeight: fontWeight ?? FontWeight.w600,
        fontSize: fontSize ?? 14,
        height: height,
      ),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }
}
