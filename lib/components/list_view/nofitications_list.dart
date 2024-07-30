import 'package:flutter/material.dart';
import 'package:kltn_mobile/models/notifications.dart';

class NotificationList extends StatefulWidget {
  final String userId;

  const NotificationList({super.key, required this.userId});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  late Future<List<Notifications>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = Notifications.getNotificationsList(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notifications>>(
      future: notifications,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No notifications found');
        } else {
          final notificationsList = snapshot.data!;
          return ListView.builder(
            itemCount: notificationsList.length,
            itemBuilder: (context, index) {
              final notification = notificationsList[index];
              return ListTile(
                title: Text(notification.title),
                subtitle: Text(notification.body),
                // Customize as needed
              );
            },
          );
        }
      },
    );
  }
}
