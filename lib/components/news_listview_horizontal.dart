import 'package:flutter/material.dart';
import 'package:kltn_mobile/View/HomePage/News/news_detail.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';

import '../Model/news.dart';

class NewsListView extends StatelessWidget {
  final List<News> newsList;

  const NewsListView({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NewsDetailPage(news: newsList[index])),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(newsList[index].thumbnailUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.1),
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
            ),
          );
        },
      ),
    );
  }
}