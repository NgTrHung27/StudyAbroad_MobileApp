import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/list_view/nofitications_list.dart';
import 'package:kltn_mobile/components/user_main_page/hello_avt.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class NotificationsPage extends BasePage {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => NotificationsPageState();
}

class NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeSettingCubit>().loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final hintText =
        localizations != null ? localizations.home_search : 'Default Text';
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: context.select(
            (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
        body: 
          ListView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.075, vertical: screenHeight*0.05),
            children: [
              const HelloAVT(username: 'John Doe'),
              const SizedBox(height: 20),
              NewsSearchTextField(hintText: hintText),
              SizedBox(height: screenHeight*0.05),
              NotificationList(),            
            ]
          ),
      );
  }
}