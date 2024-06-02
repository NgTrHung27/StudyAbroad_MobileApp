import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/list_view/nofitications_box.dart';
import 'package:kltn_mobile/models/notifications.dart';

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