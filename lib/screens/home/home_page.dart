import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/list_view/news_listview_horizontal_2.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/functions_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_slider_data_found.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:kltn_mobile/screens/home/dismissible_bottom_sheet_view.dart';


class HomePage extends BasePage {
  const HomePage({super.key, UserAuthLogin? userAuth, NewsList? newsData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarousel());
    context.read<ThemeSettingCubit>().loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    final userAuth = this.userAuth;
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
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    return Scaffold(
      backgroundColor: context.select(
          (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
      body: BlocBuilder<LanguageBloc, Locale>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
            child: ListView(
              children: [
                WelcomeAVT(username: userAuth?.name ?? 'N/A'),
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
                      return Center(child: Text(state.message));
                    } else {
                      return Container();
                    }
                  },
                ),
                TextMonserats(
                  homeActionText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColorRed,
                ),
                SizedBox(height: screenHeight * 0.01),
                const BoxGridView(),
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
                          Navigator.of(context).pushNamed('/schoolslistCanada');
                        },
                        child: SizedBox(
                            width: 330,
                            child: Image.asset('assets/countries/Canada.png')),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/schoolslistCanada');
                        },
                        child: SizedBox(
                            width: 330,
                            child:
                                Image.asset('assets/countries/Australia.png')),
                      ),
                      SizedBox(width: screenWidth * 0.02),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/schoolslistCanada');
                        },
                        child: SizedBox(
                            width: 330,
                            child: Image.asset('assets/countries/Korea.png')),
                      ),
                    ],
                  ), // Add the image here
                ),
                SizedBox(height: screenHeight * 0.02),
                TextMonserats(homeNewListText,
                    fontSize: 20, fontWeight: FontWeight.w700),
                SizedBox(height: screenHeight * 0.02),
                const NewsListViewShort(),
                SizedBox(height: screenHeight * 0.14),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingChatButton(
        onTap: (_) {
          _showBottomSheet(context);
        },
        chatIconWidget: const Padding(
          padding: EdgeInsets.all(14.0),
          child: Icon(
            Icons.perm_identity,
            color: Colors.green,
            size: 40,
          ),
        ),
        messageBackgroundColor: Colors.green,
        chatIconBorderColor: Colors.green,
        chatIconBackgroundColor: Colors.white,
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext bContext) async {
    return showModalBottomSheet(
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: bContext,
      builder: (context) => DismissibleBottomSheetView(
        childView: Container(
            width: double.infinity,
            color: Colors.white,
            child: const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Imagine this is a chat UI",
                    style: TextStyle(fontSize: 30, color: Colors.blue)),
              ),
            )),
      ),
    );
  }
}
