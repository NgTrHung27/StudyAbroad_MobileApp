import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/list_view/news_listview_vertical.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import '../../components/style/montserrat.dart';
import '../../components/style/news_searchtextfield.dart';
import '../../components/list_view/news_listview_horizontal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsPage extends BasePage {
  const NewsPage({super.key, required this.newsList});
  final List<NewsList> newsList;

  @override
  // ignore: library_private_types_in_public_api
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends BasePageState<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final userAuth = this.userAuth;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //theme
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColor = isDarkMode ? Colors.black : AppColor.redButton;
    //Language
    final localizations = AppLocalizations.of(context);
    final hintText =
        localizations != null ? localizations.home_search : 'Default Text';
    final news1 =
        localizations != null ? localizations.new_main : 'Default Text';
    final news2 =
        localizations != null ? localizations.new_post : 'Default Text';
    return Scaffold(
      backgroundColor: context.select(
          (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonCircle(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                CirleAvatarImage(
                    avatarImgUrl: userAuth?.student.school.logo != null
                        ? userAuth!.student.school.logo
                        : null,
                    avatarImgPath: 'assets/logo/logo_red.png',
                    width: 60,
                    height: 60),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            NewsSearchTextField(hintText: hintText),
            SizedBox(height: screenHeight * 0.03),
            TextMonserats(
              news1,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            const NewsListView(),
            SizedBox(height: screenHeight * 0.02),
            TextMonserats(
              news2,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
            VerticalNewsListView(newsList: widget.newsList),
          ],
        ),
      ),
    );
  }
}
