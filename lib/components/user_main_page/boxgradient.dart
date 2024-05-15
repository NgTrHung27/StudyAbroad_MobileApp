import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';

class BoxGradient extends StatelessWidget {
  const BoxGradient(
      {super.key,
      required this.color1,
      required this.color2,
      required this.smallText,
      required this.bigText});
  final Color color1;
  final Color color2;
  final String smallText;
  final String bigText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: 170,
      height: 130,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset.fromDirection(1.5, 2.5),
          ),
        ],
        color: const Color((0xffFFC107)),
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            color1.withOpacity(1),
            color2.withOpacity(1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.3, 0.9],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMonserats(
              smallText,
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            TextMonserats(bigText,
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
          ],
        ),
      ),
    );
  }
}
