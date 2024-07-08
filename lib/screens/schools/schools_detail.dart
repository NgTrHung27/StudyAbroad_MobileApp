import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/major_box.dart';
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
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final scaffoldBackgroundColor = isDarkMode ? const Color(0xff1E2334) : Colors.white;
    return Scaffold(
        body: Stack(
            children:[ 

              ListView(
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
                    color: scaffoldBackgroundColor,
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
                            length: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TabBar(
                                  isScrollable: true,
                                  labelPadding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                                  tabAlignment: TabAlignment.start,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicator: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                      color: schoolnameColor,
                                      width: 2.0,
                                    ),
                                  ),
                                  tabs: [
                                    Tab(child: TextMonserats('Description', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                    Tab(child: TextMonserats('Requirement', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                    Tab(child: TextMonserats('Majors', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                    Tab(child: TextMonserats('Scholarships', fontSize: screenWidth*0.04, fontWeight: FontWeight.bold, color: schoolnameColor,)),
                                  ],
                                ),
                                  SizedBox(
                                    height: screenHeight*0.35,
                                    child: TabBarView(
                                      children: [
                                          TextMonserats(
                                            widget.school.description??'',
                                              fontSize: 16.0,
                                              color: textColor,
                                          ),
                                        const Center(child: Text('Courses Content')),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: screenHeight*0.02, bottom: screenHeight*0.02),
                                              child: TextMonserats('Programs of ${widget.school.name}',
                                                fontWeight: FontWeight.w700,
                                                color: schoolnameColor,
                                                fontSize: screenWidth*0.05,
                                                height: 1.3),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: MajorBox(programs: widget.school.programs),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(top: screenHeight*0.02, bottom: screenHeight*0.02),
                                                  child: TextMonserats('Scholarhips of ${widget.school.name}',
                                                    fontWeight: FontWeight.w700,
                                                    color: schoolnameColor,
                                                    fontSize: screenWidth*0.05,
                                                    height: 1.3),
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: MajorBox(programs: widget.school.programs),
                                                  ),
                                                ),
                                              ],
                                            ),
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
            Positioned(
              top: screenHeight*0.05,
              left: screenWidth*0.01,
              child: const BackButtonCircle()
            ),
          ]
        ),
    );
  }
}