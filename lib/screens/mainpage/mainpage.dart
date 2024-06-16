import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/navbar/bottom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/home_page.dart';
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
    const Profile(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final home =
        localizations != null ? localizations.nav_home : 'Default Text';
    final noti =
        localizations != null ? localizations.nav_noti : 'Default Text';
    final profile =
        localizations != null ? localizations.nav_profile : 'Default Text';

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _children,
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
                      icon: 'assets/iconNoti',
                      label: noti,
                      onTap: () => onTabTapped(1)),
                  BottomNavbarItem(
                      icon: 'assets/iconUser',
                      label: profile,
                      onTap: () => onTabTapped(2)),
                ],
                initialIndex: _currentIndex,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
