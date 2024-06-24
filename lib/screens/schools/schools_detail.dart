import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/news_listview_horizontal.dart';
import 'package:kltn_mobile/models/schools.dart';

class SchoolsDetail extends StatefulWidget {
  final Schools school;
  const SchoolsDetail({super.key, required this.school});

  @override
  SchoolsDetailState createState() => SchoolsDetailState();
}

class SchoolsDetailState extends State<SchoolsDetail> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final schoolnameColor = isDarkMode ? Colors.white : AppColor.redButton;
    return DefaultTabController(
      length: 3, // Số lượng tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.school.name),
        ),
        body: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Image.network(widget.school.background, fit: BoxFit.cover),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -screenWidth*0.5, 0.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: context.select((ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextMonserats(widget.school.name,
                        fontWeight: FontWeight.w700,
                        color: schoolnameColor,
                        fontSize: screenWidth*0.07,
                        height: 1.3),
                     DefaultTabController(
                        length: 3, // Số lượng tabs
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TabBar(
                              labelPadding: EdgeInsets.zero,
                              indicator: UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  color: schoolnameColor,
                                  width: 2.0,
                                ),
                              ),
                              tabs: [
                                Tab(child: TextMonserats('Description', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                Tab(child: TextMonserats('Requirement', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                Tab(child: TextMonserats('Major', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                              ],
                            ),
                            SizedBox(
                              height: screenHeight*0.35, // Đặt chiều cao cho TabBarView
                              child: TabBarView(
                                children: [
                                  // Nội dung cho mỗi tab
                                  Center(child: Text(widget.school.description??'')),
                                  const Center(child: Text('Courses Content')),
                                  const Center(child: Text('Reviews Content')),
                                ],
                              ),
                            ),
                            TextMonserats('School News',
                              fontWeight: FontWeight.w700,
                              color: schoolnameColor,
                              fontSize: screenWidth*0.04,
                              height: 1.3),
                            // Danh sách tin tức
                            SizedBox(height: screenHeight*0.02),
                            const NewsListView(),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}