import 'package:flutter/material.dart';

class FunctionItem {
  final String name;
  final IconData icon;
  final bool isEnable;
  final bool
      switchValue; // Thêm một thuộc tính để xác định trạng thái của công tắc

  FunctionItem({
    required this.name,
    required this.icon,
    this.isEnable = false,
    this.switchValue = false, // Mặc định trạng thái là false (tắt)
  });
}
