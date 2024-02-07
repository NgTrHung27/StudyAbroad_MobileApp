import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email',
          style: GoogleFonts.getFont(
            'Montserrat',
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              fillColor: Colors.white,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey[400]),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10), // Điều chỉnh khoảng trống bên trong ô input
            ),
          ),
        ),
      ],
    );
  }
}
