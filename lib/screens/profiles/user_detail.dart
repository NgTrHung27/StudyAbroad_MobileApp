import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/functions/profile_userdetailbox.dart';
import 'package:kltn_mobile/models/user_login.dart';

class UserDetailsPage extends StatelessWidget {
  final UserAuthLogin userAuth;

  const UserDetailsPage({super.key, required this.userAuth});

  @override
  Widget build(BuildContext context) {
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
                        const TextMonserats('Profile',
                            fontSize: 22, fontWeight: FontWeight.bold),
                        SizedBox(height: screenHeight * 0.02),
                        const CirleAvatarImage(
                            avatarImgPath:
                                'assets/backgrounds/backgr_logout.jpg',
                            width: 120,
                            height: 120),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Full name',
                            value: userAuth.name ?? 'N/A',
                            isEditable: true),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Email', value: userAuth.email ?? 'N/A'),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'ID Student',
                            value: userAuth.student?.school?.name ?? 'N/A'),
                        SizedBox(height: screenHeight * 0.02),
                        LegendBox(
                            title: 'Status',
                            value: userAuth.student?.program?.program?.name ??
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
