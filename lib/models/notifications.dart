import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class Notifications {
  String id;
  String title;
  String body;
  String type;
  String senderName;
  bool isRead;
  String receiverId;
  DateTime createdAt;
  DateTime updatedAt;

  Notifications({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.senderName,
    required this.isRead,
    required this.receiverId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) {
    return Notifications(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      type: json['type'],
      senderName: json['senderName'],
      isRead: json['isRead'],
      receiverId: json['receiverId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  static Future<List<Notifications>> getNotificationsList(String userId) async {
    try {
      List<Notifications> notifications = [];
      await http
          .get(Uri.parse(
              "https://admin-cemc-co.vercel.app/api/notifications/$userId"))
          .then((res) {
        if (res.statusCode == 200) {
          final data = json.decode(res.body) as List;

          notifications = data.map((json) {
            return Notifications.fromJson(json);
          }).toList();
        }
      });

      log('Fetched notifications: $notifications');
      return notifications;
    } catch (_) {
      log('Failed to fetch notifications');

      return [];
    }
  }
}
