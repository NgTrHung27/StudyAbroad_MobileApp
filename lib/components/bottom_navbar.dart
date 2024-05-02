import 'package:flutter/material.dart';

class BottomNavbarItem {
  final IconData icon;
  final String label;

  BottomNavbarItem({required this.icon, required this.label});
}

class BottomNavbar extends StatefulWidget {
  final List<BottomNavbarItem> items;

  const BottomNavbar({super.key, required this.items});

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 45),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(45)),
          child: Center(
            child: NavigationBar(
              height: 55,
              backgroundColor: Colors.white,
              indicatorColor: const Color(0xff7D1F1F),
              selectedIndex: currentIndex,
              onDestinationSelected: (index) {
                setState(() {
                  currentIndex = index;
                  print('Tapped on item $index');
                });
              },
              destinations: widget.items.map((item) {
                return NavigationDestination(
                   icon: Icon(
                      item.icon,
                      size: 30.0, // tăng kích thước icon
                    ),
                    label: item.label,
                    selectedIcon: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 30.0, // tăng kích thước icon khi được chọn
                    ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}