import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/screens/chatting/chatting_gemini_ai.dart';
import 'package:kltn_mobile/screens/chatting/floating_chatting_position.dart';
import 'package:kltn_mobile/screens/chatting/dismissible_chatting_gemini_ai.dart';

import 'home_page.dart';
import '../notifications/notifications_page.dart';
import '../profiles/profile.dart';

class MainPage extends StatefulWidget {
  final int initialIndex = 0;
  const MainPage({super.key, initialIndex = 0});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late int _currentIndex;

  final List<Widget> _bodyView = [
    const HomePage(),
    const GeminiAI(),
    const NotificationsPage(),
    const Profile()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map && args.containsKey('index')) {
      setState(() {
        _currentIndex = args['index'];
        print(' Did $_currentIndex');
      });
    }
  }

  Widget _tabItem(String icon, String label, int index) {
    bool isSelected = _currentIndex == index;
    String iconPath =
        isSelected ? '${icon}_selected.png' : '${icon}_unselected.png';

    return GestureDetector(
      onTap: () => onTabTapped(index),
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8),
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 500),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColor.redLight,
              ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(iconPath, width: 24),
            Container(
              transform: Matrix4.translationValues(0.0, 3.0, 0.0),
              child: TextMonserats(
                label,
                fontSize: 12,
                color: isSelected ? Colors.white : AppColor.redButton,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> _icons = [
    'assets/iconHome',
    'assets/iconMess',
    'assets/iconNoti',
    'assets/iconUser',
  ];

  @override
  Widget build(BuildContext context) {
    bool isRunningOnAndroid = Platform.isAndroid;
    final floatingHeight = isRunningOnAndroid ? 0.12 : 0.08;
    final screenHeight = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context);
    final home =
        localizations != null ? localizations.nav_home : 'Default Text';
    final chatAI =
        localizations != null ? localizations.ai_chatting_nav : 'Default Text';
    final noti =
        localizations != null ? localizations.nav_noti : 'Default Text';
    final profile =
        localizations != null ? localizations.nav_profile : 'Default Text';
    final List<String> labels = [home, chatAI, noti, profile];
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          Center(
            child: _bodyView.elementAt(_currentIndex),
          ),
          // Floating bottom navigation bar
          if (_currentIndex != 1)
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.transparent,
                height: 105,
                padding: const EdgeInsets.all(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    height: 80,
                    color: Colors.white.withOpacity(1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_icons.length, (index) {
                        return _tabItem(_icons[index], labels[index], index);
                      }),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: _currentIndex != 1
          ? FloatingActionButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              backgroundColor: AppColor.redLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const ImageIcon(
                AssetImage('assets/icons_3d/chatbot.png'),
                size: 30,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: CustomFABLocation(
        FloatingActionButtonLocation.endFloat,
        screenHeight * floatingHeight,
      ),
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
                child: Text("Chat AI",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ),
            )),
      ),
    );
  }
}
