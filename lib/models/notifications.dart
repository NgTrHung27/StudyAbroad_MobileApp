import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Notifications {
  final String? schoolAvt;
  final String? schoolName;
  final String? notiTitle;
  final String? notiContent;
  final String? time;

  Notifications({
    this.schoolAvt,
    this.schoolName,
    this.notiTitle,
    this.notiContent,
    this.time,
  });
  static Future<void> saveNotifications(
      List<Notifications> notifications) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> notiList =
        notifications.map((noti) => noti.toJson()).toList();
    await prefs.setStringList('notifications', notiList);
  }

  static Future<List<Notifications>> loadNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? notiList = prefs.getStringList('notifications');
    if (notiList == null) return [];
    return notiList.map((noti) => Notifications.fromJson(noti)).toList();
  }

  String toJson() {
    return '{"schoolAvt": "$schoolAvt", "schoolName": "$schoolName", "notiTitle": "$notiTitle", "notiContent": "$notiContent", "time": "$time"}';
  }

  static Notifications fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);
    return Notifications(
      schoolAvt: json['schoolAvt'],
      schoolName: json['schoolName'],
      notiTitle: json['notiTitle'],
      notiContent: json['notiContent'],
      time: json['time'],
    );
  }
}
