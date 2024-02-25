import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 330,
        height: 40,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: const Color(0xff7D1F1F),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          "Login",
          style: GoogleFonts.getFont('Montserrat',
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        )),
      ),
    );
  }
}