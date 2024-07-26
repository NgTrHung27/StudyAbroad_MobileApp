import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/models/tuition.dart';

class TuitionBox extends StatelessWidget {
  final Tuition tuition;

  const TuitionBox({super.key, required this.tuition});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    Color statusColor;
    switch (tuition.tuitionStatus) {
      case 'Paid':
        statusColor = const Color(0xff65AF37);
        break;
      case 'Unpaid':
        statusColor = const Color(0xffC81D1D);
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final boxColor = isDarkMode ? const Color(0xff3F3F46) : Colors.white;
    final textColor = isDarkMode ? Colors.white : AppColor.redButton;

    return Container(
      margin: EdgeInsets.only(
          left: screenwidth * 0.06,
          right: screenwidth * 0.06,
          bottom: screenHeight * 0.02),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenwidth * 0.05, vertical: screenHeight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextMonserats(
                  'Semester ${tuition.semester}',
                  color: textColor,
                  fontSize: screenwidth * 0.04,
                ),
                SizedBox(height: screenHeight * 0.01),
                TextMonserats(
                  '\$${tuition.tuition}',
                  color: Colors.red,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            Transform(
              transform:
                  Matrix4.translationValues(0.0, -screenHeight * 0.02, 0.0),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.008,
                    horizontal: screenwidth * 0.05),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                constraints: BoxConstraints(
                  minWidth: screenwidth * 0.33,
                ),
                child: Center(
                  child: TextMonserats(
                    tuition.tuitionStatus,
                    color: Colors.white,
                    fontSize: screenwidth * 0.036,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
