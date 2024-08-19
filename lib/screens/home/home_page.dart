import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/list_view/news_listview_horizontal_2.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/functions_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_slider_data_found.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/Authentication/auth_data_notify.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:kltn_mobile/screens/schools/schools_list.dart';
import 'package:showcaseview/showcaseview.dart';

class HomePage extends BasePage {
  const HomePage({super.key, NewsList? newsData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarousel());
    context.read<ThemeSettingCubit>().loadTheme();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ShowCaseWidget.of(context).startShowCase([_one, _two, _three]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final userAuth =
        this.userAuth ?? context.watch<UserAuthProvider>().userAuthLogin;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    //Language
    final localizations = AppLocalizations.of(context);
    final homeActionText =
        localizations != null ? localizations.home_action : 'Default Text';
    final homeExploreText =
        localizations != null ? localizations.home_exlore : 'Default Text';
    final homeNewListText =
        localizations != null ? localizations.home_NewList : 'Default Text';
    final errorConn =
        localizations != null ? localizations.error_connection : "Defalut Text";
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return Scaffold(
        backgroundColor: context.select(
            (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
        body: Stack(
          children: [
            BlocBuilder<LanguageBloc, Locale>(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01),
                  child: ListView(
                    controller: _scrollController,
                    children: [
                      WelcomeAVT(username: userAuth?.name ?? 'User'),
                      SizedBox(height: screenHeight * 0.01),
                      const NewsSearchTextField(),
                      SizedBox(height: screenHeight * 0.02),
                      BlocBuilder<CarouselBloc, CarouselState>(
                        builder: (context, state) {
                          if (state is CarouselLoading) {
                            return const CarouselLoadingCustom();
                          } else if (state is CarouselLoaded) {
                            return CarouselSliderDataFound(state.carousels);
                          } else if (state is CarouselError) {
                            print(state.message.toString());
                            return Center(child: Text(errorConn));
                          } else {
                            return Container();
                          }
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextMonserats(
                            homeActionText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: textColorRed,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          const BoxGridView(),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: screenHeight * 0.01),
                          TextMonserats(
                            homeExploreText,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: textColorRed,
                          ),
                          SizedBox(height: screenHeight * 0.01),
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SchoolsListPage(
                                                country: 'CANADA'),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                      width: 330,
                                      child: Image.asset(
                                          'assets/countries/Canada.png')),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SchoolsListPage(
                                                country: 'AUSTRALIA'),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                      width: 330,
                                      child: Image.asset(
                                          'assets/countries/Australia.png')),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SchoolsListPage(
                                                country: 'KOREA'),
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                      width: 330,
                                      child: Image.asset(
                                          'assets/countries/Korea.png')),
                                ),
                              ],
                            ), // Add the image here
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          TextMonserats(homeNewListText,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: textColorRed),
                          SizedBox(height: screenHeight * 0.02),
                          const NewsListViewShort(
                            nullSchool: null,
                          ),
                          SizedBox(height: screenHeight * 0.14),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ));
  }
}
