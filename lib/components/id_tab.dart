import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IdTab extends StatefulWidget {
  final String userName;
  final String idUser;
  final String avatarImgPath; // Default avatar image path

  const IdTab({
    super.key,
    required this.userName,
    required this.idUser,
    this.avatarImgPath = 'assets/backgr-01.jpg', // Optional default image
  });

  @override
  State<IdTab> createState() => _IdTabState();
}

class _IdTabState extends State<IdTab> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: 80,
      width: screenWidth * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xff7D1F1F),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 20,
            bottom: 10,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: (widget.avatarImgPath != 'assets/backgr-01.jpg')
                      ? AssetImage(widget.avatarImgPath)
                      : const AssetImage('assets/backgr-01.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 17,
            left: 85,
            bottom: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName, // Name User
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.idUser, // ID User
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
