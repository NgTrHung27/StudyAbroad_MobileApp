import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/action/id_tab.dart';
import 'package:kltn_mobile/components/action/id_tab_logout.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class TuitionStatus extends BasePage {
  const TuitionStatus({super.key});

  @override
  TuitionStatusState createState() => TuitionStatusState();
}

class TuitionStatusState extends BasePageState<TuitionStatus> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.08),
          Center(
            child: IdTab(
              userName: userAuth?.name ?? 'N/A',
              idUser: userAuth?.id ?? 'N/A',
              avatarImgUrl: userAuth?.student.school.logo != null
                  ? userAuth!.student.school.logo
                  : null, // Sử dụng hình ảnh từ API nếu có
              avatarImgPath: 'assets/logo/logo_white.png',
            ),
          )
        ],
      ),
    );
  }
}
