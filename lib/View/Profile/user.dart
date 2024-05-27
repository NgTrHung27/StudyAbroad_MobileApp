import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/action_tab.dart';
import 'package:kltn_mobile/components/id_tab.dart';
import 'package:kltn_mobile/components/main_bottom_navbar.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  //UserID and UserName
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IdTab(
                        userName: 'N/A',
                        idUser: 'N/A',
                        avatarImgPath: 'assets/Bckgr_Login.jpg',
                      ),
                    ], // parameters userName+idUser and avatarUser
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ActionTab(
                    header: 'Account',
                    functions: [
                      FunctionItem(name: 'Profile', icon: Icons.person),
                      FunctionItem(name: 'Change Password', icon: Icons.key),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: 'Status',
                    functions: [
                      FunctionItem(name: 'Profile', icon: Icons.account_circle),
                      FunctionItem(
                          name: 'Schoolarship', icon: Icons.school_outlined),
                      FunctionItem(name: 'Tuition', icon: Icons.payment),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: 'Settings',
                    functions: [
                      FunctionItem(name: 'Language', icon: Icons.language),
                      FunctionItem(
                          name: 'Screen mode',
                          icon: Icons.nightlight_round,
                          isEnable: true,
                          switchValue: true),
                      FunctionItem(
                          name: 'Help & Feedback',
                          icon: Icons.question_mark_rounded),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Logout');
                    },
                    child: const TextMonserats('Logout',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          // const Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: MainNavBar(),
          // )
        ],
      ),
    );
  }
}
