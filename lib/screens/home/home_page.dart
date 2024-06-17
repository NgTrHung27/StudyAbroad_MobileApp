import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/functions_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/functions_main_page/carousel_slider_data_found.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/models/user_login.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:kltn_mobile/screens/schools/schools_countries_main_.dart';

class HomePage extends BasePage {
  const HomePage({super.key, UserAuthLogin? userAuth});

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
    final hintText =
        localizations != null ? localizations.home_search : 'Default Text';
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
                NewsSearchTextField(hintText: hintText),
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
                const SizedBox(height: 5),
                TextMonserats(
                  homeExploreText,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColorRed,
                ),
                const SizedBox(
                  height: 200,
                  child: CountrySchoolList(
                    schools: [],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                TextMonserats(homeNewListText,
                    fontSize: 20, fontWeight: FontWeight.w700),
              ],
            ),
          );
        },
      ),
    );
  }
}
