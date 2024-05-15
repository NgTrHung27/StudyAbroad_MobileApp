import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/carousel_event_state/carousel_bloc.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/news_searchtextfield.dart';
import 'package:kltn_mobile/components/main_bottom_navbar.dart';
import 'package:kltn_mobile/components/user_main_page/gridview_box.dart';
import 'package:kltn_mobile/components/user_main_page/hello_avt.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_loading.dart';
import 'package:kltn_mobile/components/user_main_page/carousel_slider_data_found.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch the carousel data when the widget is initialized
    context.read<CarouselBloc>().add(FetchCarousel());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          child: Stack(children: [
            ListView(
              children: [
                const HelloAVT(username: 'John Doe'),
                const SizedBox(height: 20),
                const NewsSearchTextField(hintText: 'Search here...'),
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
                      return Container(); // Initial state or any other state handling
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
      ),
    );
  }
}
