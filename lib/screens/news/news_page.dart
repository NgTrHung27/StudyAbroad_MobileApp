import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/list_view/news_listview_vertical.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import '../../components/style/montserrat.dart';
import '../../components/style/news_searchtextfield.dart';
import '../../components/list_view/news_listview_horizontal.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 20, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BackButtonCircle(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const CirleAvatarImage(
                          avatarImgPath: 'assets/backgr-01.jpg'),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: NewsSearchTextField(hintText: 'Search here...'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const TextMonserats('Main News',
                        fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 30, bottom: 15),
                  child: NewsListView(),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: const TextMonserats('Daily Post',
                        fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: VerticalNewsListView(newsList: widget.newsList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
