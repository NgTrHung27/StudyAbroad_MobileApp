import 'package:flutter/material.dart';

class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  final double verticalOffset;
  final double horizontalOffset;

  CustomFloatingActionButtonLocation(
      {this.verticalOffset = 0, this.horizontalOffset = 0});

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    final double fabWidth = scaffoldGeometry.floatingActionButtonSize.width;
    final double fabHeight = scaffoldGeometry.floatingActionButtonSize.height;
    final double width = scaffoldGeometry.scaffoldSize.width;
    final double height = scaffoldGeometry.scaffoldSize.height;
    final double appBarHeight = scaffoldGeometry.minInsets.top;

    double x = horizontalOffset >= 0
        ? width - fabWidth - horizontalOffset
        : -horizontalOffset;
    // Điều chỉnh y để không bị khuất phía trên
    double y = verticalOffset >= 0
        ? height - fabHeight - verticalOffset
        : -verticalOffset +
            appBarHeight; // Thêm appBarHeight để tránh bị khuất bởi AppBar hoặc status bar

    return Offset(x, y);
  }
}
