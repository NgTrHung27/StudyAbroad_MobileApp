import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/bloC/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/main_bottom_navbar.dart';
import 'package:kltn_mobile/components/user_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/user_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_slider_data_found.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarousel());
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Stack(children: [
          ListView(
            children: [
              const HelloAVT(username: 'John Doe'),
              const SizedBox(height: 20),
              const NewsSearchTextField(hintText: 'Search here...'),
              const SizedBox(height: 15),
              IconButton(
                  onPressed: toggleTheme,
                  icon: !isChangeColor
                      ? const Icon(
                          Icons.sunny,
                          color: Colors.amberAccent,
                        )
                      : const Icon(
                          Icons.brightness_3,
                          color: Colors.amberAccent,
                        )),
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
              const TextMonserats('Actions',
                  fontSize: 20, fontWeight: FontWeight.w700),
              const SizedBox(height: 10),
              const BoxGridView(),
              const SizedBox(height: 5),
              const TextMonserats('What\'s New?',
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
      ),
    );
  }
}
