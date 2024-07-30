import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? token;

  Future<void> initNotifications() async {
    // Request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();
    // Fetch the FCM token for this device
    token = await _firebaseMessaging.getToken();
    // Print the token
    print('FCM KLTN Token: $token');
    // await postTokenToWebAdmin(fCMToken); // Send to Admin
  }

  Future<String> getFCMToken() async {
    // Ensure initNotifications has been called
    if (token == null) {
      await initNotifications();
    }
    return token ?? '';
  }

  // Function to post FCM token to web admin
  Future<void> postTokenToWebAdmin(String? token) async {
    if (token == null) return;

    final url = Uri.parse('https://kltn-demo-deploy-admin.vercel.app/api');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'token': token}),
    );

    if (response.statusCode == 200) {
      print('Token posted successfully');
    } else {
      print('Failed to post token: ${response.statusCode}');
    }
  }
}
