import 'package:flutter/material.dart';
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
    final localizations = AppLocalizations.of(context);
    final hintText =
        localizations != null ? localizations.home_search : 'Default Text';
    final news1 =
        localizations != null ? localizations.new_main : 'Default Text';
    final news2 =
        localizations != null ? localizations.new_post : 'Default Text';
    return Scaffold(
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
                        avatarImgPath: 'assets/backgrounds/backgr_logout.jpg'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: NewsSearchTextField(hintText: hintText),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextMonserats(news1,
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30, bottom: 15),
                child: NewsListView(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: TextMonserats(news2,
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                child: VerticalNewsListView(newsList: widget.newsList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
