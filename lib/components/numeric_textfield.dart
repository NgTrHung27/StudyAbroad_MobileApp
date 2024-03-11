import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class NumericTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final IconData? additionalIcon;
  final double? fontSize; // Added fontSize as an optional parameter
  final Null Function(dynamic value) onChanged; // Added onChanged function

  const NumericTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.additionalIcon,
    this.fontSize,
    required this.onChanged, // Added onChanged function
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 37,
      width: 315,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFCBD5E1)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 9,
                bottom: 9,
                left: 13,
                right: 5,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  prefixIcon,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number, // chỉ cho phép nhập số
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
    );
  }
}
