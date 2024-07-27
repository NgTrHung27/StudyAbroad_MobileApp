import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/action/id_tab.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/tuition_box.dart';
import 'package:kltn_mobile/models/tuition.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class TuitionStatus extends BasePage {
  const TuitionStatus({super.key});

  @override
  TuitionStatusState createState() => TuitionStatusState();
}

class TuitionStatusState extends BasePageState<TuitionStatus> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : AppColor.redButton;

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: screenHeight * 0.08),
              Center(
                child: TextMonserats(
                  'Tuition Status',
                  fontSize: screenHeight * 0.03,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: IdTab(
                  userName: userAuth?.name ?? 'N/A',
                  idUser: userAuth?.email ?? 'N/A',
                  avatarImgUrl: userAuth?.student.school.logo != null
                      ? userAuth!.student.school.logo
                      : null, // Sử dụng hình ảnh từ API nếu có
                  avatarImgPath: 'assets/logo/logo_white.png',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dummyTuitionData.length,
                  itemBuilder: (context, index) {
                    return TuitionBox(tuition: dummyTuitionData[index]);
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: screenHeight * 0.075,
            left: 16,
            child: BackButtonCircle(
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
