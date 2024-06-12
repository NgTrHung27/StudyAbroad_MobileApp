import 'package:flutter/material.dart';

class CirleAvatarImage extends StatelessWidget {
  final String avatarImgPath;
  final double width;
  final double height;

  const CirleAvatarImage({
    super.key,
    required this.avatarImgPath,
    this.width = 50.0,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: (avatarImgPath != 'assets/backgrounds/backgr_logout.jpg')
              ? AssetImage(avatarImgPath)
              : const AssetImage('assets/backgrounds/backgr_logout.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
