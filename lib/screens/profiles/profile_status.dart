import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/profile_status_cubit_bloc/profile_status_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/action/actiontab_result.dart';
import 'package:kltn_mobile/components/action/actiontab_stepper.dart';
import 'package:kltn_mobile/components/action/id_tab.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class ProfileStatus extends BasePage {
  const ProfileStatus({super.key});
  @override
  State<ProfileStatus> createState() => _ProfileStatusState();
}

class _ProfileStatusState extends BasePageState<ProfileStatus> {
  @override
  Widget build(BuildContext context) {
    final userAuth = this.userAuth;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenwidth = MediaQuery.of(context).size.width;
    //Theme
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return BlocProvider(
      create: (context) =>
          ProfileStatusCubit()..updateStatus(userAuth?.student.status ?? 'N/A'),
      child: BlocBuilder<ProfileStatusCubit, ProfileStatusState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.08),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BackButtonCircle(onPressed: () {
                              Navigator.pop(context);
                            }),
                            TextMonserats(
                              'Profile Status',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: textColorRed,
                            ),
                            Container(
                              width: screenwidth * 0.15,
                            )
                          ], // parameters userName+idUser and avatarUser
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      //UserID and UserName
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IdTab(
                            userName: userAuth?.name ?? 'N/A',
                            idUser: '',
                            avatarImgPath: userAuth?.student.school.logo ??
                                'assets/logo/logo_red.png',
                          ),
                        ], // parameters userName+idUser and avatarUser
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      //Stepper
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Stepper auto generate step 2
                          ActionTabStepper(
                              header: 'Profile Status',
                              stepTexts: const [
                                'Application has been submitted',
                                'Awaiting review',
                                'Done'
                              ],
                              status: userAuth?.student.status ?? 'N/A'),
                        ],
                      ),
                      const SizedBox(height: 20),

                      //Result Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ActiontabResult(
                              result: userAuth?.student.status ?? 'N/A'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
