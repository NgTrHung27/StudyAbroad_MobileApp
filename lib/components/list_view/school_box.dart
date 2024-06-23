import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/models/schools.dart';
import 'package:kltn_mobile/screens/schools/schools_detail.dart';

class SchoolBox extends StatelessWidget {
  final Schools school;
  const SchoolBox({super.key, required this.school});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final boxColor = isDarkMode ? const Color(0xff3F3F46) : Colors.white;
    return Padding(
      padding: EdgeInsets.only( bottom: screenHeight * 0.015),
      child: GestureDetector(
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SchoolsDetail(school: school)),
          );
        },
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(
                    school.background,
                    height: screenHeight * 0.23,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: screenHeight * 0.23,
                    decoration:  BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, AppColor.redButton.withOpacity(0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.26,
                color: boxColor,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06, vertical: screenHeight * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMonserats(
                      school.name,
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                      height: 1.3,
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: textColor,
                          size: screenWidth * 0.05,
                        ),
                        Expanded(
                          child: TextMonserats(
                            '166-220 Holloway Rd, Australian',
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    TextMonserats(
                      school.short ?? 'no short description',
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                      height: 1.3,
                      overflow: TextOverflow.ellipsis,
                      maxLine: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}