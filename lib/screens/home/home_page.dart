import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/blocs/lang_cubit/language_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/navbar/main_bottom_navbar.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/user_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/user_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_slider_data_found.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';

class HomePage extends BasePage {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarousel());
    context.read<ThemeSettingCubit>().loadTheme();
  }

  @override
  Widget build(BuildContext context) {
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
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Stack(children: [
              ListView(
                children: [
                  const HelloAVT(username: 'John Doe'),
                  const SizedBox(height: 20),
                  NewsSearchTextField(hintText: hintText),
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 10),
                  const BoxGridView(),
                  const SizedBox(height: 5),
                  TextMonserats(
                    homeExploreText,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: textColorRed,
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextMonserats(homeNewListText,
                      fontSize: 20, fontWeight: FontWeight.w700),
                ],
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MainNavBar(),
              ),
            ]),
          );
        },
      ),
    );
  }
}
