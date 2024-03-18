import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final IconData? additionalIcon;
  final double? fontSize; // Added fontSize as an optional parameter

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.prefixIcon,
    this.additionalIcon,
    this.fontSize, required Null Function(dynamic value) onChanged, // Added fontSize as an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 355,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 13,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      prefixIcon,
                      size: 21,
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: hintText, // Remove hintText from here
                      hintStyle: GoogleFonts.montserrat
                      (color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 15,
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      additionalIcon,
                      size: 21,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
