import 'package:flutter/material.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:kltn_mobile/screens/scholarships/scholarships_detail.dart';
import 'package:provider/provider.dart'; // Adjust the import path as necessary

class ScholarshipsBox extends BasePage {
  const ScholarshipsBox({super.key});

  @override
  ScholarshipsBoxState createState() => ScholarshipsBoxState();
}

class ScholarshipsBoxState extends BasePageState<ScholarshipsBox> {
  @override
  Widget build(BuildContext context) {
    final userAuthLogin = userAuth;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.white : AppColor.redButton;
    final boxColor = isDarkMode ? AppColor.backgrTabDark : Colors.white;
    return ListView.builder(
      itemCount: userAuthLogin?.student.scholarship.length ?? 0,
      itemBuilder: (context, index) {
        final scholarship = userAuthLogin!.student.scholarship[index];
        return Container(
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              title: TextMonserats(scholarship.scholarship.name,fontSize: 16.0, fontWeight: FontWeight.bold, color: textColor,),
              trailing: const Icon(Icons.arrow_forward_ios, size: 20.0),
              onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScholarshipsDetail(
                    name: scholarship.scholarship.name,
                    description: scholarship.scholarship.description,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}