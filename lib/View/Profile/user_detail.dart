import 'package:flutter/material.dart';
import 'package:kltn_mobile/Model/user_login.dart';

class UserDetailsPage extends StatelessWidget {
  final UserAuthLogin userAuth;

  const UserDetailsPage({super.key, required this.userAuth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Name: ${userAuth.name}'),
            Text('Email: ${userAuth.email}'),
            Text('Degree Type: ${userAuth.student?.degreeType}'),
            Text('Status: ${userAuth.student?.status}'),
            // Add more fields as needed
          ],
        ),
      ),
    );
  }
}