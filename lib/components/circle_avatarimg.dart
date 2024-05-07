import 'package:flutter/material.dart';

class CirleAvatarImage extends StatelessWidget {
  final String avatarImgPath;

  const CirleAvatarImage({super.key, required this.avatarImgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (avatarImgPath != 'assets/backgr-01.jpg')
              ? AssetImage(avatarImgPath)
              : const AssetImage('assets/backgr-01.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}