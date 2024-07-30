import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:kltn_mobile/models/user_login.dart';

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
  String schoolAvt;
  String schoolName;

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
    required this.schoolAvt,
    required this.schoolName,
  });

  static Future<List<Notifications>> getNotificationsList(String userId) async {
    try {
      final res = await http
          .get(Uri.parse(
              "https://admin-cemc-co.vercel.app/api/notifications/$userId"))
          .then((res) {
        if (res.statusCode == 200) {
          final data = res.body;
          print('data: $data');
          return [];
        }
      });

      return [];
    } catch (_) {
      log('Failed to fetch notifications');

      return [];
    }
    // return [
    //   Notifications(
    //     schoolAvt:
    //         'https://images.pexels.com/photos/1366630/pexels-photo-1366630.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    //     schoolName: 'Huflit America',
    //     title: 'Thông báo mới nè vô xem thoai !!!',
    //     body:
    //         'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using ',
    //     time: '5 minutes ago',
    //   ),
    // ];
  }
}
