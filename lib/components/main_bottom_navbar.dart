import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/bottom_navbar.dart';

class MainNavBar extends StatelessWidget {
  final BottomNavbar? bottomNavbar;

  const MainNavBar({super.key, this.bottomNavbar});

  @override
  Widget build(BuildContext context) {
    return BottomNavbar(
      items: [
        BottomNavbarItem(
            icon: 'assets/iconHome',
            label: 'Home',
            onTap: () => Navigator.pushNamed(context,
                '/home')), // Pass the path without _selected or _unselected
        BottomNavbarItem(
            icon: 'assets/iconNoti',
            label: 'Notifications',
            onTap: () => Navigator.pushNamed(context, '/news')),
        BottomNavbarItem(
            icon: 'assets/iconUser',
            label: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, '/user');
            }),
      ],
      initialIndex: 0,
    );
  }
}
