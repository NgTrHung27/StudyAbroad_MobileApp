import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text; // Thêm tham số text
  const MyButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //365
        width: screenWidth * 0.8,
        height: 41,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: const Color(0xff7D1F1F),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Color of the shadow
              spreadRadius: 2, // Spread radius
              blurRadius: 3, // Blur radius
              offset: const Offset(0, 5), // Offset in x and y directions
            ),
          ],
        ),
        child: Center(
          child: Text(
            text, // Sử dụng tham số text
            style: GoogleFonts.getFont(
              'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
