import 'package:flutter/material.dart';

class ActiontabResult extends StatefulWidget {
  final String result;

  const ActiontabResult({Key? key, required this.result}) : super(key: key);

  @override
  State<ActiontabResult> createState() => _ActiontabResultState();
}

class _ActiontabResultState extends State<ActiontabResult> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Color backgroundColor = Colors.grey; //In

    // Define color for each result
    if (widget.result == 'Approved') {
      backgroundColor = const Color(0xff65AF37);
    } else if (widget.result == 'Denied') {
      backgroundColor = const Color(0xffB61919);
    } else if (widget.result == 'Pending') {
      backgroundColor = Colors.grey;
    }

    return Container(
      height: 50,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: backgroundColor,
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
      child: Center(
        child: Text(
          widget.result,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}