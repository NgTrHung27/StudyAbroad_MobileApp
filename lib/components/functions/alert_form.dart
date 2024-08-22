import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/functions/button.dart';

class AlertDialogComponent extends StatelessWidget {
  const AlertDialogComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: TextMonserats(
        'Form Submitted',
        fontSize: screenWidth * 0.06,
        fontWeight: FontWeight.w500,
      ),
      icon: Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: screenWidth * 0.18,
      ),
      actions: <Widget>[
        Center(
          child: MyButton(
            text: 'Xác nhận',
            onTap: () {
              Navigator.pushNamed(context, '/mainpage');
            },
          ),
        ),
      ],
    );
  }
}
