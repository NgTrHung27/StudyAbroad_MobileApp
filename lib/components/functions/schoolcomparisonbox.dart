import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class ComparisonChart extends StatelessWidget {
  final String titleComparison;
  final List<String> schoolNames;

  const ComparisonChart({
    super.key,
    required this.titleComparison,
    required this.schoolNames,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : AppColor.redButton;

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey[600]!,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextMonserats(
                titleComparison,
                color: textColor,
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: schoolNames.map((name) {
                  final double percentage = Random().nextDouble() * 100;
                  return Column(
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        constraints: const BoxConstraints(
                          minHeight: 80,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: 200,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: screenWidth * 0.15,
                                height: percentage * 2.0,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xffF58218),
                                      Color(0xff9C2424),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              child: Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: schoolNames.map((name) {
            return SizedBox(
              width: screenWidth * 0.3,
              child: TextMonserats(
                name,
                color: textColor,
                fontSize: screenWidth * 0.033,
                fontWeight: FontWeight.w600,
                maxLine: 3,
                height: 1.2,
                textAlign: TextAlign.center,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
