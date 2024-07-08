import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/schools_cubit/schools_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/school_box.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class SchoolsListPage extends StatefulWidget {
  const SchoolsListPage({super.key, required this.country});
  final String country;

  @override
  State<SchoolsListPage> createState() => _SchoolsListPageState();
}

class _SchoolsListPageState extends State<SchoolsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<SchoolsCubit>().getSchoolListByCountry(widget.country);
  }

  Color getColorForCountry(String country) {
  switch (country.toUpperCase()) {
    case 'CANADA':
      return AppColor.redButton;
    case 'AUSTRALIA':
      return const Color(0xff2D3D7A);
    case 'KOREA':
      return const Color(0xff2BB6CF);
    default:
      return Colors.grey; // Một màu mặc định nếu không khớp với bất kỳ trường hợp nào
  }
}

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final exploreColor = isDarkMode ? Colors.white : AppColor.redButton;

    return Scaffold(
      body: BlocBuilder<SchoolsCubit, SchoolsState>(
        builder: (context, state) {
          if (state is SchoolsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SchoolsLoaded) {
            return SingleChildScrollView(
              child: Stack(
                children: [ Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.15,
                          color: getColorForCountry(widget.country),
                          child: Padding(
                            padding: EdgeInsets.only(top: screenHeight * 0.03),
                            child: Center(
                              child: TextMonserats(
                                widget.country,
                                color:Colors.white,
                                fontSize: screenWidth * 0.07,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                      ),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                         child: Padding(
                          padding: EdgeInsets.only(top: screenHeight*0.025 ),
                          child: TextMonserats(
                            'Explore Schools',
                            color: exploreColor,
                            fontSize: screenWidth*0.045,
                            fontWeight: FontWeight.w700,
                          ),
                                             ),
                       ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.schoolList.length,
                          itemBuilder: (context, index) {
                            final school = state.schoolList[index];
                            return SchoolBox(school: school);
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: screenHeight*0.06,
                    left: screenWidth*0.03,
                    child: const BackButtonCircle()
                  ),
                ],
              ),
            );
          } else if (state is SchoolsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}
