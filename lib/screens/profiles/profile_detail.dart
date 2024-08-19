import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/functions/profile_userdetailbox.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileDetail extends BasePage {
  const ProfileDetail({super.key});

  @override
  State<ProfileDetail> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends BasePageState<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    final userAuth =
        this.userAuth ?? context.watch<UserAuthProvider>().userAuthLogin;

    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final titleColor = isDarkMode ? Colors.white : AppColor.redButton;
    //Language
    final localizations = AppLocalizations.of(context);
    final profile = localizations != null
        ? localizations.profile_account_profilesInfo
        : 'Default Text';
    return BlocBuilder<ThemeSettingCubit, ThemeData>(
      builder: (context, state) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;
        return Scaffold(
          backgroundColor: context.select(
              (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.15),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextMonserats(
                          profile,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: titleColor,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        CirleAvatarImage(
                            avatarImgUrl: userAuth?.student.school.logo != null
                                ? userAuth!.student.school.logo
                                : null,
                            avatarImgPath: 'assets/logo/logo_red.png',
                            width: 120,
                            height: 120),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Full name',
                            value: userAuth?.name ?? 'N/A',
                            isEditable: true),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Email', value: userAuth?.email ?? 'N/A'),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'ID Student',
                            value: userAuth?.student.school.name ?? 'N/A'),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Status',
                            value: userAuth!.student.program?.program.name ??
                                'N/A'),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: screenWidth * 0.13,
                left: 10.0,
                child: BackButtonCircle(onPressed: () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
