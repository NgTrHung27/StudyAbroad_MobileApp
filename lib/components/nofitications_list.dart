import 'package:flutter/material.dart';
import 'package:kltn_mobile/Model/notifications.dart';
import 'package:kltn_mobile/components/nofitications_box.dart';

class NotificationList extends StatelessWidget {
  final notifications = Notifications.getSampleData();

  NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: notifications.map((notification) => NotificationBox(notification: notification)).toList(),
    );
  }
}