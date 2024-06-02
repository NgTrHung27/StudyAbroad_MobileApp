import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/models/news.dart';
import 'package:kltn_mobile/screens/news/news_detail.dart';

class VerticalNewsListView extends StatelessWidget {
  final List<NewsList> newsList;

  const VerticalNewsListView({super.key, required this.newsList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
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
            margin: const EdgeInsets.only(bottom: 10),
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2, // 40% of the box
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    child: Image.asset(
                      newsList[index].cover,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3, // 60% of the box
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        TextMonserats(newsList[index].title, fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}