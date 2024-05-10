// FILE: text_field.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final int? maxLines;
  final IconData? additionalIcon;
  final double? fontSize;
  final Null Function(dynamic value) onChanged;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final Function()? onpressed;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.prefixIcon,
      this.maxLines,
      this.additionalIcon,
      this.fontSize,
      required this.onChanged,
      this.keyboardType,
      this.textCapitalization,
      this.onpressed});

  @override
  // ignore: library_private_types_in_public_api
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = true;
  String hintText = '';
  IconData prefixIcon = Icons.person;
  IconData iconButton = Icons.remove_red_eye;
  TextEditingController controller = TextEditingController();
  bool obscureText = false;
  int? maxLines;
  IconData? additionalIcon;
  double? fontSize;
  Null Function(dynamic value)? onChanged;
  TextInputType? keyboardType;
  TextCapitalization? textCapitalization;
  Function()? onpressed;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 43,
      width: screenWidth * 0.85,
      child: TextField(
        //
        controller: widget.controller,
        obscureText: widget.obscureText ? _obscureText : false,
        maxLines: maxLines ?? 1,
        onChanged: widget.onChanged,
        autofocus: true,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
        //Con trỏ |
        cursorHeight: 20,
        cursorWidth: 1.5,
        //Decoration of TextField
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: fontSize ?? 14,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(
              widget.prefixIcon,
              size: 20,
              color: Colors.black,
            ),
            suffixIcon: widget.obscureText
                ? IconButton(
                    color: Colors.black,
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            hintStyle: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w400,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFCBD5E1)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            contentPadding: const EdgeInsets.all(10)),
      ),
    );
  }
}
