import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownCustom<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String hintText;
  final Function(T?) onChanged;
  final String Function(T) itemLabel;
  final bool isExpanded;
  final IconData? icon;

  const DropdownCustom({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemLabel,
    required this.hintText,
    required this.isExpanded, 
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(
        hintText,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: selectedItem,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<T>>((T value) {
        return DropdownMenuItem<T>(
          value: value,
          child: Text(
            itemLabel(value),
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
      isExpanded: isExpanded,
      decoration: InputDecoration(
        prefixIcon: Icon(icon ?? Icons.map, color: Colors.black),
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(color: Colors.white),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 2,
        ),
      ),
    );
  }
}
