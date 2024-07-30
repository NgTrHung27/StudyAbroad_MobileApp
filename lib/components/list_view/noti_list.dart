import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kltn_mobile/models/notifications.dart';

class ListNoti extends StatefulWidget {
  const ListNoti({super.key, required this.notifications});
  final Future<List<Notifications>> notifications;

  @override
  State<ListNoti> createState() => _ListNotiState();
}

class _ListNotiState extends State<ListNoti> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Notifications>>(
      future: widget.notifications,
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
