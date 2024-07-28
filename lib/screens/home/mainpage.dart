import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions/alert_dialog.dart';
import 'package:kltn_mobile/components/navbar/bottom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/authentication/auth_notify.dart';
import 'package:kltn_mobile/screens/chatting/floating_chatting_position.dart';
import 'package:provider/provider.dart';
import 'package:kltn_mobile/screens/chatting/dismissible_chatting_gemini_ai.dart';

import 'home_page.dart';
import '../notifications/notifications_page.dart';
import '../profiles/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const NotificationsPage(),
    const Profile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.watch<AuthNotifier>().isLoggedIn;
    final localizations = AppLocalizations.of(context);
    final home =
        localizations != null ? localizations.nav_home : 'Default Text';
    final chatAI =
        localizations != null ? localizations.ai_chatting_nav : 'Default Text';
    final noti =
        localizations != null ? localizations.nav_noti : 'Default Text';
    final profile =
        localizations != null ? localizations.nav_profile : 'Default Text';

    return Stack(
      children: [
        Scaffold(
          body: IndexedStack(
            index: _currentIndex,
            children: _children,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showBottomSheet(context);
            },
            backgroundColor: AppColor.redLight,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: const ImageIcon(
              AssetImage('assets/icons_3d/chatbot.png'),
              size: 30,
              color: Colors.white,
            ),
          ),
          floatingActionButtonLocation: CustomFABLocation(
            FloatingActionButtonLocation.endFloat,
            100.0,
          ),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BottomNavbar(
              items: [
                BottomNavbarItem(
                    icon: 'assets/iconHome',
                    label: home,
                    onTap: () => onTabTapped(0)),
                BottomNavbarItem(
                    icon: 'assets/iconMess',
                    label: chatAI,
                    onTap: () {
                      Navigator.pushNamed(context, '/chatting');
                    }),
                BottomNavbarItem(
                  icon: 'assets/iconNoti',
                  label: noti,
                  // onTap: () => onTabTapped(1)),
                  onTap: () {
                    isLoggedIn
                        ? onTabTapped(1)
                        : showCustomDialog(
                            context: context,
                            onConfirm: () {
                              Navigator.pushNamed(context, '/login');
                            },
                          );
                  },
                ),
                BottomNavbarItem(
                    icon: 'assets/iconUser',
                    label: profile,
                    onTap: () => onTabTapped(2)),
              ],
              initialIndex: _currentIndex,
            ),
          ),
        )
      ],
    );
  }

  Future<void> _showBottomSheet(BuildContext bContext) async {
    return showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: bContext,
      builder: (context) => DismissibleBottomSheetView(
        childView: Container(
            width: double.infinity,
            color: Colors.white,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Imagine this is a chat UI",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ),
            )),
      ),
    );
  }
}
