import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionTab extends StatelessWidget {
  final String header; //parameter header

  const ActionTab({super.key, required this.header});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 100,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0, left: 20),
          child: Text(
            header, // parameter header
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: const Color(0xff7D1F1F),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
