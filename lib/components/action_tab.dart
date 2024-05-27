import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class FunctionItem {
  final String name;
  final IconData icon;

  FunctionItem({required this.name, required this.icon});
}

class ActionTab extends StatelessWidget {
  final String header;
  final List<FunctionItem> functions; // Parameter functions

  const ActionTab({
    super.key,
    required this.header,
    this.functions =
        const [], // Initialize functions as an empty list if not provided
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16.0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextMonserats(
            header, // Parameter header
            fontSize: 17,
            color: AppColor.redButton,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 15), // Space between header and functions
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: functions.asMap().entries.map((entry) {
              int idx = entry.key;
              FunctionItem function = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(function.icon, color: Colors.black, size: 25),
                        const SizedBox(
                            width: 15), // Space between icon and text
                        TextMonserats(
                          function.name, // Parameter function
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    if (idx != functions.length - 1)
                      const SizedBox(height: 12), // Space between functions
                    const SizedBox(height: 8), // Space between functions
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
