import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/navbar/bottom_navbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainNavBar extends StatelessWidget {
  final BottomNavbar? bottomNavbar;

  const MainNavBar({super.key, this.bottomNavbar});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final home =
        localizations != null ? localizations.nav_home : 'Default Text';
    final noti =
        localizations != null ? localizations.nav_noti : 'Default Text';
    final profile =
        localizations != null ? localizations.nav_profile : 'Default Text';
    return BottomNavbar(
      items: [
        BottomNavbarItem(
            icon: 'assets/iconHome',
            label: home,
            onTap: () => Navigator.pushNamed(context,
                '/home')), // Pass the path without _selected or _unselected
        BottomNavbarItem(
            icon: 'assets/iconMess',
            label: profile,
            onTap: () {
              Navigator.pushNamed(context, '/user');
            }),
        BottomNavbarItem(
            icon: 'assets/iconNoti',
            label: noti,
            onTap: () => Navigator.pushNamed(context, '/notifications')),
        BottomNavbarItem(
            icon: 'assets/iconUser',
            label: profile,
            onTap: () {
              Navigator.pushNamed(context, '/user');
            })
        
      ],
      initialIndex: 0,
    );
  }
}
