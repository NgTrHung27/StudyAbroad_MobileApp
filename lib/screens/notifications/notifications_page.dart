import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/list_view/nofitications_list.dart';
import 'package:kltn_mobile/components/functions_main_page/hello_avt.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class NotificationsPage extends BasePage {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => NotificationsPageState();
}

class NotificationsPageState extends BasePageState<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ThemeSettingCubit>().loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = this.userAuth;   
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: context.select(
          (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
        child: ListView(children: [
          WelcomeAVT(username: userAuth?.name ?? 'N/A'),
          SizedBox(height: screenHeight * 0.01),
          const NewsSearchTextField(),
          SizedBox(height: screenHeight * 0.04),
          NotificationList(),
        ]),
      ),
    );
  }
}
