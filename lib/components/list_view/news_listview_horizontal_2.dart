import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/news_cubit_bloc/news_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/news/news_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewsListViewShort extends StatefulWidget {
  const NewsListViewShort({super.key});

  @override
  NewsListViewShortState createState() => NewsListViewShortState();
}

class NewsListViewShortState extends State<NewsListViewShort> {
  List<NewsList> newsList = [];

  @override
  void initState() {
    super.initState();
    context.read<NewsCubit>().getNewsList();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final errorConn =
        localizations != null ? localizations.error_connection : "Defalut Text";
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is NewsError) {
          print(state.message.toString());
          return Center(child: Text(errorConn));
        }
        if (state is NewsLoaded) {
          newsList = state.newsList;
          return buildNewsList();
        }
        print('error state: $state');
        return Container();
      },
    );
  }

  Widget buildNewsList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewsDetailPage(news: newsList[index])),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(newsList[index].cover),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextMonserats(
                    newsList[index].title,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
