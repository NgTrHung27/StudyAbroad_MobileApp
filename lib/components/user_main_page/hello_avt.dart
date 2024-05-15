import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/circle_avatarimg.dart';

class HelloAVT extends StatelessWidget {
  const HelloAVT({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextMonserats(
              'Hello,',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            TextMonserats(username, fontSize: 23, fontWeight: FontWeight.w700),
          ],
        ),
        const CirleAvatarImage(avatarImgPath: 'assets/backgr-01.jpg'),
      ],
    );
  }
}
