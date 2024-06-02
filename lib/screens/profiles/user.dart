import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/action/action_tab.dart';
import 'package:kltn_mobile/components/action/id_tab.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UserProfile extends BasePage {
  const UserProfile({super.key});
  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  void initState() {
    super.initState();
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
                  //UserID and UserName
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IdTab(
                        userName: AppLocalizations.of(context)!.home_hello,
                        idUser: 'N/A',
                        avatarImgPath: 'assets/Bckgr_Login.jpg',
                      ),
                    ], // parameters userName+idUser and avatarUser
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  ActionTab(
                    backgroundColor: backgroundColor,
                    header: AppLocalizations.of(context)!.profile_account,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                          name: AppLocalizations.of(context)!
                              .profile_account_profilesInfo,
                          icon: Icons.person),
                      FunctionItem(
                          name: AppLocalizations.of(context)!
                              .profile_account_changePassword,
                          icon: Icons.key),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  ActionTab(
                    header: AppLocalizations.of(context)!.profile_status,
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                          name: AppLocalizations.of(context)!.profile_status_ps,
                          icon: Icons.account_circle),
                      FunctionItem(
                          name:
                              AppLocalizations.of(context)!.profile_status_ps1,
                          icon: Icons.school_outlined),
                      FunctionItem(
                          name:
                              AppLocalizations.of(context)!.profile_status_ps2,
                          icon: Icons.payment),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),

                  ActionTab(
                    header: AppLocalizations.of(context)!.profile_setting,
                    backgroundColor: backgroundColor,
                    colorIcon: colorIcon,
                    functions: [
                      FunctionItem(
                        name: AppLocalizations.of(context)!
                            .profile_setting_Language,
                        icon: Icons.language,
                        dropdownCallback: (Locale newValue) {
                          // Accept the new value
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
                          name: AppLocalizations.of(context)!
                              .profile_setting_Screenmode,
                          icon: Icons.nightlight_round,
                          isEnable: true,
                          switchValue: false),
                      FunctionItem(
                          name: AppLocalizations.of(context)!
                              .profile_setting_Support,
                          icon: Icons.question_mark_rounded),
                    ], // List of functions
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/logout');
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
        ],
      ),
    );
  }
}
