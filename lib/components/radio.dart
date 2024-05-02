import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final Function(T?) onChanged;
  final String title;

  const CustomRadio({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 37,
        child: ListTile(
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ),
          ),
          leading: Radio<T>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
          ),
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
