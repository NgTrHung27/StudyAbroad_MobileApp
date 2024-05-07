import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavbarItem {
  final IconData icon;
  final String label;

  BottomNavbarItem({
    required this.icon, 
    required this.label
    });
}

class BottomNavbar extends StatefulWidget {
  final List<BottomNavbarItem> items;
  final int initialIndex;

  const BottomNavbar({super.key, required this.items, this.initialIndex = 0});

  @override
  BottomNavbarState createState() => BottomNavbarState();
}

class BottomNavbarState extends State<BottomNavbar> {
  late int _selectedIndex;
  
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius:45,offset: Offset(0, 15), blurStyle: BlurStyle.normal),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(45)),
          child: CupertinoTabBar(
            items: widget.items.map((item) {
              return BottomNavigationBarItem(
                icon: _buildIcon(item.icon, widget.items.indexOf(item), item.label),
                label: '',
              );
            }).toList(),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            height: 80,
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(IconData iconData, int index, String label) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final labelWidth = _measureText(label, TextStyle(color: _selectedIndex == index ? Colors.white : Colors.grey)).width;
        return Container(
          padding: const EdgeInsets.only(top: 15),
          child: Center(
            child: Container(
              width: labelWidth + 35,
              height: 85,
              decoration: _selectedIndex == index
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(35), // Half of the height
                      color: const Color(0xffAF3737),
                    )
                  : null,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(iconData, color: _selectedIndex == index ? Colors.white : const Color(0xff7D1F1F)),
                    Text(label, style: GoogleFonts.getFont('Montserrat' ,color: _selectedIndex == index ? Colors.white : const Color(0xff7D1F1F), fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Size _measureText(String text, TextStyle style) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }
}