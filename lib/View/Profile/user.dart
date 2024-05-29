import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/action_tab.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/id_tab.dart';
import 'package:kltn_mobile/components/main_bottom_navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarousel());
    context.read<ThemeSettingCubit>().loadTheme();

    _loadIconState();
  }

  Future<void> _loadIconState() async {
    final prefs = await SharedPreferences.getInstance();
    isChangeColor = prefs.getBool('isChangeColor') ?? false;
    setState(() {});
  }

  bool isChangeColor = false;
  void toggleTheme() {
    context.read<ThemeSettingCubit>().toggleTheme();
    setState(() {
      isChangeColor = !isChangeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final backgroundColor = context.select(
      (ThemeSettingCubit cubit) => cubit.state == AppTheme.blackTheme
          ? AppColor.backgrTabDark // Màu nền khi ở chế độ dark
          : AppColor.backgrTabLight, // Màu nền khi ở chế độ light
    );
    final colorIcon = context.select(
      (ThemeSettingCubit cubit) => cubit.state == AppTheme.blackTheme
          ? Colors.white // Màu nền khi ở chế độ dark
          : Colors.black, // Màu nền khi ở chế độ light
    );

// Màu nền khi ở chế độ light
    return Scaffold(
      backgroundColor: context.select(
          (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
      body: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  //UserID and UserName
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IdTab(
                        userName: 'N/A',
                        idUser: 'N/A',
                        avatarImgPath: 'assets/Bckgr_Login.jpg',
                      ),
                    ], // parameters userName+idUser and avatarUser
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ActionTab(
                    backgroundColor: backgroundColor,
                    header: 'Account',
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(name: 'Profile', icon: Icons.person),
                      FunctionItem(name: 'Change Password', icon: Icons.key),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: 'Status',
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(name: 'Profile', icon: Icons.account_circle),
                      FunctionItem(
                          name: 'Schoolarship', icon: Icons.school_outlined),
                      FunctionItem(name: 'Tuition', icon: Icons.payment),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: 'Settings',
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(name: 'Language', icon: Icons.language),
                      FunctionItem(
                          name: 'Screen mode',
                          icon: Icons.nightlight_round,
                          isEnable: true,
                          switchValue: false),
                      FunctionItem(
                          name: 'Help & Feedback',
                          icon: Icons.question_mark_rounded),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/Logout');
                    },
                    child: const TextMonserats('Logout',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
          // const Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: MainNavBar(),
          // )
        ],
      ),
    );
  }
}
