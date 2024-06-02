import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class LegendBox extends StatelessWidget {
  final String title;
  final String value;

  const LegendBox({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: 65.0,
              constraints: const BoxConstraints(minWidth: double.infinity),
              padding: const EdgeInsets.only(top: 12.0), 
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Align(alignment: Alignment.centerLeft, child: TextMonserats(value, color: value == 'APPROVED' ? Colors.green : value == 'DENIED' ? Colors.red : Colors.black,)),
                ),
              ),
            ),
            Positioned(
              left: 15.0,
              child: Container(
                color: Colors.white, 
                padding: const EdgeInsets.symmetric(horizontal: 7.0), 
                child: TextMonserats(
                  title, color: Colors.grey, fontSize: 15.0, fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}