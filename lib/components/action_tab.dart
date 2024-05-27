import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // Import Cupertino library
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class FunctionItem {
  final String name;
  final IconData icon;
  final bool isEnable;
  bool switchValue;

  FunctionItem({
    required this.name,
    required this.icon,
    this.isEnable = false,
    this.switchValue = false,
  });
}

class ActionTab extends StatefulWidget {
  final String header;
  final List<FunctionItem> functions;

  const ActionTab({
    super.key,
    required this.header,
    this.functions = const [],
  });

  @override
  _ActionTabState createState() => _ActionTabState();
}

class _ActionTabState extends State<ActionTab> {
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
            widget.header,
            fontSize: 17,
            color: AppColor.redButton,
            fontWeight: FontWeight.w600,
          ),
          const SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.functions.asMap().entries.map((entry) {
              int idx = entry.key;
              FunctionItem function = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(function.icon, color: Colors.black, size: 25),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextMonserats(
                            function.name,
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (function.isEnable)
                          CupertinoSwitch(
                            value: function.switchValue,
                            onChanged: (value) {
                              setState(() {
                                function.switchValue = value;
                              });
                            },
                          ),
                      ],
                    ),
                    if (idx != widget.functions.length - 1)
                      const SizedBox(height: 12),
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
