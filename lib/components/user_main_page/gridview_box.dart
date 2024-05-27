import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/user_main_page/boxgradient.dart';

class BoxGridView extends StatelessWidget {
  const BoxGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 330,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 17,
        mainAxisSpacing: 17,
        childAspectRatio: 1.2,
        children: [
          BoxGradient(
            color1: const Color(0xffFF9736),
            color2: const Color(0xffC41010),
            smallText: 'See your',
            bigText: 'Score',
            onTap: () {
              Navigator.pushNamed(context, "/news");
            },
            image: const AssetImage('assets/medal.png'),
          ),
          BoxGradient(
            color1: const Color(0xff86E0D0),
            color2: const Color(0xff3A9571),
            smallText: 'Watch',
            bigText: 'News',
            onTap: () {
              Navigator.pushNamed(context, "/news");
            },
            image: const AssetImage('assets/newspaper.png'),
          ),
          BoxGradient(
            color1: const Color(0xff80E8FF),
            color2: const Color(0xff297BC5),
            smallText: 'Contacts for',
            bigText: 'Comments',
            onTap: () {
              Navigator.pushNamed(context, "/news");
            },
            image: const AssetImage('assets/3d-contact.png'),
          ),
        ],
      ),
    );
  }
}
