import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kltn_mobile/models/notifications.dart';

class ListNoti extends StatefulWidget {
  const ListNoti({super.key, required this.notifications});
  final List<Notifications> notifications;

  @override
  State<ListNoti> createState() => _ListNotiState();
}

class _ListNotiState extends State<ListNoti> {
  @override
  Widget build(BuildContext context) {
    final message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    if (message == null) {
      return const Column(
        children: [Text('No message received')],
      );
    }
    print('List Noti Test $message');

    return Column(
      children: [
        Text(' ${message.notification?.title.toString()}'),
        Text('${message.notification?.body.toString()}'),
        Text(message.data.toString()),
      ],
    );
  }
}
