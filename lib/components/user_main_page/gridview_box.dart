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
        children: const [
          BoxGradient(
              color1: Color(0xffDE5C4D),
              color2: Color(0xffC91717),
              smallText: 'See your',
              bigText: 'Score'),
          BoxGradient(
              color1: Color(0xff67D292),
              color2: Color(0xff4EBF93),
              smallText: 'Watch',
              bigText: 'News'),
          BoxGradient(
              color1: Color(0xff8ED3FF),
              color2: Color(0xff4D91CD),
              smallText: 'Contacts for',
              bigText: 'Comments'),
        ],
      ),
    );
  }
}
