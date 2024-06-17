import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CirleAvatarImage extends StatefulWidget {
  final String? avatarImgUrl;
  final String avatarImgPath;
  final double width;
  final double height;

  const CirleAvatarImage({
    super.key,
    required this.avatarImgPath,
    this.width = 50.0,
    this.height = 50.0,
    this.avatarImgUrl,
  });
  @override
  State<CirleAvatarImage> createState() => _CirleAvatarImageState();
}

class _CirleAvatarImageState extends State<CirleAvatarImage> {
  @override
  Widget build(BuildContext context) {
    final ImageProvider<Object> imageWidget = widget.avatarImgUrl != null
        ? CachedNetworkImageProvider(widget.avatarImgUrl!)
            as ImageProvider<Object>
        : AssetImage(widget.avatarImgPath) as ImageProvider<Object>;
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: imageWidget,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
