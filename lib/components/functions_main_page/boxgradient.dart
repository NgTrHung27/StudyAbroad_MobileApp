import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class BoxGradient extends StatelessWidget {
  final Color color1;
  final Color color2;
  final String smallText;
  final String bigText;
  final Function()? onTap;
  final AssetImage image;
  const BoxGradient(
      {super.key,
      required this.color1,
      required this.color2,
      required this.smallText,
      required this.bigText,
      this.onTap,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              color2.withOpacity(0.85),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: null,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 0, left: 15, right: 0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextMonserats(
                        smallText,
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: TextMonserats(bigText,
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            maxLine: 2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 5, left: 15, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image(
                    image: image,
                    width: 65,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
