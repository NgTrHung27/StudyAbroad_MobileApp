import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/bottom_navbar.dart';

class MainNavBar extends StatelessWidget {
  final BottomNavbar? bottomNavbar;

  const MainNavBar({super.key, this.bottomNavbar});

  @override
  Widget build(BuildContext context) {
    return BottomNavbar(
    items:  [
      BottomNavbarItem(icon: Icons.home_outlined, label: 'Home'),
      BottomNavbarItem(icon: Icons.notifications_outlined, label: 'Notifications'),
      BottomNavbarItem(icon: Icons.settings, label: 'Settings'),
    ]
   );
  }
}