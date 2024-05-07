import 'package:flutter/material.dart';
import 'package:kltn_mobile/Model/news.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/circle_avatarimg.dart';
import 'package:kltn_mobile/components/news_listview_vertical.dart';
import '../../../components/Style/montserrat.dart';
import '../../../components/Style/news_searchtextfield.dart';
import '../../../components/news_listview_horizontal.dart';


class NewsPage extends StatelessWidget {
  const NewsPage({super.key, required this.newsList});
  
  final List<News> newsList;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      body: SafeArea(
          child: Container(
            color: const Color(0xffF9F9F9),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonCircle(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const CirleAvatarImage(avatarImgPath: 'assets/backgr-01.jpg'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: NewsSearchTextField(hintText: 'Search here...'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: Container( 
                    alignment: Alignment.centerLeft,
                    child: const TextMonserats('Main News', fontSize: 26, fontWeight: FontWeight.w800 ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, bottom: 15),
                  child: NewsListView(newsList: newsList),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const TextMonserats('Daily Post', fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: VerticalNewsListView(newsList: newsList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}