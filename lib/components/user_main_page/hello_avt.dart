import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/circle_avatarimg.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HelloAVT extends StatelessWidget {
  const HelloAVT({super.key, required this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final homeHello =
        localizations != null ? localizations.home_search : 'Default Text';
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextMonserats(
              homeHello,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
            TextMonserats(
              username,
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: textColorRed,
            ),
          ],
        ),
        const CirleAvatarImage(avatarImgPath: 'assets/backgr-01.jpg'),
      ],
    );
  }
}
