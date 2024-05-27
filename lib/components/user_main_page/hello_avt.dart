import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/circle_avatarimg.dart';
import 'package:kltn_mobile/components/constant/theme.dart';

class HelloAVT extends StatelessWidget {
  const HelloAVT({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextMonserats(
              'Hello,',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            TextMonserats(username, fontSize: 23, fontWeight: FontWeight.w700),
          ],
        ),
        Row(
          children: [
            // Icon(context.watch<ThemeSettingCubit>().state ==
            //         AppTheme.lightTheme
            //     ? Icons.wb_sunny
            //     : Icons.brightness_3),
            CupertinoSwitch(
              value: context.watch<ThemeSettingCubit>().state ==
                  AppTheme.blackTheme,
              onChanged: (value) {
                context.read<ThemeSettingCubit>().toggleTheme();
              },
            ),
          ],
        ),
        const CirleAvatarImage(avatarImgPath: 'assets/backgr-01.jpg'),
      ],
    );
  }
}
