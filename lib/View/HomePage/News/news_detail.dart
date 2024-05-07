// FILE:NEWS_DETAIL.DART CONTEXT
import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import '../../../Model/news.dart';
import '../../../components/Style/backbutton.dart';

class NewsDetailPage extends StatelessWidget {
  final News news;
  const NewsDetailPage({super.key, required this.news});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width, // full screen width
                  height: MediaQuery.of(context).size.height * 0.5, // half screen height
                  child: Image.asset(news.thumbnailUrl, fit: BoxFit.cover),  // thumbnail image
                ),
                Container(
                  transform: Matrix4.translationValues(0.0, -120.0, 0.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextMonserats(news.title, fontWeight: FontWeight.w700, color: Colors.black, fontSize: 22),  // title
                        const SizedBox(height: 10),
                        TextMonserats(news.content,fontWeight: FontWeight.w500, color: Colors.black, fontSize: 20),  // content
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: BackButtonCircle(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}