import 'package:flutter/material.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:provider/provider.dart';

class ApplyPage extends BasePage {
  final String title;

  const ApplyPage({super.key, required this.title});

  @override
  ApplyPageState createState() => ApplyPageState();
}

class ApplyPageState extends BasePageState<ApplyPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        getUserAuth(context);
      }
    });
  }

  Future<UserAuthLogin?> getUserAuth(BuildContext context) async {
    return userAuth ?? context.watch<UserAuthProvider>().userAuthLogin;
  }

  final apiUrl =
      'https://kltn-demo-deploy-admin.vercel.app/api/schools//scholarships/[scholarshipId]';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter your data',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
