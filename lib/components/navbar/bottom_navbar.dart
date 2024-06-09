import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class BottomNavbarItem {
  final String icon;
  final String label;
  final Function onTap;

  BottomNavbarItem(
      {required this.icon, required this.label, required this.onTap});
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
      widget.items[index].onTap();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top:Radius.circular(45), bottom: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 45,
                offset: Offset(0, 15),
                blurStyle: BlurStyle.normal),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(45)),
          child: CupertinoTabBar(
            backgroundColor: AppColor.scafflodBgColor,
            items: widget.items.map((item) {
              return BottomNavigationBarItem(
                icon: _buildIcon(
                    item.icon, widget.items.indexOf(item), item.label),
                label: '',
              );
            }).toList(),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            height: 80,
          ),
        ),
      );
  }

  Widget _buildIcon(String iconData, int index, String label) {
    // Changed from IconData to String
    return LayoutBuilder(
      builder: (context, constraints) {
        final labelWidth = _measureText(
                label,
                TextStyle(
                    color:
                        _selectedIndex == index ? Colors.white : Colors.grey))
            .width;
        return Container(
          padding: const EdgeInsets.only(top: 12),
          child: Center(
            child: Container(
              width: labelWidth + 45,
              height: 85,
              decoration: _selectedIndex == index
                  ? BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(35), // Half of the height
                      color: const Color(0xffAF3737),
                    )
                  : null,
              child: Container(
                transform: Matrix4.translationValues(0.0, 3.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: SizedBox(
                          width: 24.0,
                          height: 24.0,
                          child: Image.asset(_selectedIndex == index
                              ? '${iconData}_selected.png'
                              : '${iconData}_unselected.png')),
                    ), // Use Image.asset
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(label,
                          style: GoogleFonts.getFont('Montserrat',
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : const Color(0xff7D1F1F),
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                    ),
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
