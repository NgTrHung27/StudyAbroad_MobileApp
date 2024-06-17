import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/auth_cubit_bloc/login_cubit.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/style/simplebutton.dart';
import 'package:kltn_mobile/components/action/action_tab.dart';
import 'package:kltn_mobile/components/action/id_tab.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends BasePage {
  const Profile({super.key});

  @override
  State<Profile> createState() => _UserProfileState();
}

class _UserProfileState extends BasePageState<Profile> {
  bool isChangeColor = false;

  @override
  void initState() {
    super.initState();
    _loadIconState();
  }

  Future<void> _loadIconState() async {
    final prefs = await SharedPreferences.getInstance();
    isChangeColor = prefs.getBool('isChangeColor') ?? false;
    setState(() {});
  }

  void toggleTheme() {
    context.read<ThemeSettingCubit>().toggleTheme();
    setState(() {
      isChangeColor = !isChangeColor;
    });
  }

  void userLogout(BuildContext context) {
    context.read<LoginCubit>().logout();
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = this.userAuth;
    final localizations = AppLocalizations.of(context);
    final hello =
        localizations != null ? localizations.home_hello : 'Default Text';
    final account =
        localizations != null ? localizations.profile_account : 'Default Text';
    final account1 = localizations != null
        ? localizations.profile_account_profilesInfo
        : 'Default Text';
    final account2 = localizations != null
        ? localizations.profile_account_changePassword
        : 'Default Text';
    final status =
        localizations != null ? localizations.profile_status : 'Default Text';
    final status1 = localizations != null
        ? localizations.profile_status_ps
        : 'Default Text';
    final status2 = localizations != null
        ? localizations.profile_status_ps1
        : 'Default Text';
    final status3 = localizations != null
        ? localizations.profile_status_ps2
        : 'Default Text';
    final setting =
        localizations != null ? localizations.profile_setting : 'Default Text';
    final setting1 = localizations != null
        ? localizations.profile_setting_Language
        : 'Default Text';
    final setting2 = localizations != null
        ? localizations.profile_setting_Screenmode
        : 'Default Text';
    final setting3 = localizations != null
        ? localizations.profile_setting_Support
        : 'Default Text';
    final logout =
        localizations != null ? localizations.profile_logout : 'Default Text';

    final screenHeight = MediaQuery.of(context).size.height;
    final backgroundColor = context.select(
      (ThemeSettingCubit cubit) => cubit.state == AppTheme.blackTheme
          ? AppColor.backgrTabDark
          : AppColor.backgrTabLight,
    );
    final colorIcon = context.select(
      (ThemeSettingCubit cubit) =>
          cubit.state == AppTheme.blackTheme ? Colors.white : Colors.black,
    );

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
                  // UserID and UserName
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IdTab(
                        userName: hello,
                        idUser: userAuth?.name ?? 'N/A',
                        avatarImgUrl: userAuth?.student.school.logo != null
                            ? userAuth!.student.school.logo
                            : null, // Sử dụng hình ảnh từ API nếu có

                        avatarImgPath: 'assets/logo/logo_red.png',
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ActionTab(
                    backgroundColor: backgroundColor,
                    header: account,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                          name: account1,
                          icon: Icons.person,
                          onTap: () {
                            Navigator.pushNamed(context, '/profiledetail');
                          }),
                      FunctionItem(name: account2, icon: Icons.key),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: status,
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                          name: status1,
                          icon: Icons.account_circle,
                          onTap: () {
                            Navigator.pushNamed(context, '/profilestatus');
                          }),
                      FunctionItem(name: status2, icon: Icons.school_outlined),
                      FunctionItem(name: status3, icon: Icons.payment),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: setting,
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                        name: setting1,
                        icon: Icons.language,
                        dropdownCallback: (Locale newValue) {
                          switch (newValue.languageCode) {
                            case 'en':
                              context
                                  .read<LanguageBloc>()
                                  .add(LanguageEvent.setEnglish);
                              break;
                            case 'ko':
                              context
                                  .read<LanguageBloc>()
                                  .add(LanguageEvent.setKorean);
                              break;
                            case 'vi':
                              context
                                  .read<LanguageBloc>()
                                  .add(LanguageEvent.setVietnamese);
                              break;
                          }
                        },
                      ),
                      FunctionItem(
                        name: setting2,
                        icon: Icons.nightlight_round,
                        isEnable: true,
                        switchValue: false,
                      ),
                      FunctionItem(
                          name: setting3, icon: Icons.question_mark_rounded),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      userLogout(context);
                      Navigator.pushNamed(context, '/logout');
                    },
                    child: TextMonserats(logout,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: screenHeight * 0.2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
