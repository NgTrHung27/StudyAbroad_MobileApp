import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/schools_cubit/schools_cubit.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/list_view/school_box.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class SchoolsListPage extends StatefulWidget {
  const SchoolsListPage({super.key, required this.country});
  final String country; // Ensure this exists

  @override
  State<SchoolsListPage> createState() => _SchoolsListPageState();
}

class _SchoolsListPageState extends State<SchoolsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<SchoolsCubit>().getSchoolList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final exploreColor = isDarkMode ? Colors.white : AppColor.redButton;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools List'),
      ),
      body: BlocBuilder<SchoolsCubit, SchoolsState>(
        builder: (context, state) {
          if (state is SchoolsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SchoolsLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Padding(
                      padding: EdgeInsets.only(top: screenHeight*0.025, bottom: screenHeight*0.015),
                      child: TextMonserats(
                        'Explore Schools',
                        color: exploreColor,
                        fontSize: screenWidth*0.045,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.schoolList.length,
                      itemBuilder: (context, index) {
                        final school = state.schoolList[index];
                        return SchoolBox(school: school);
                      },
                    ),
                  ],
                ),
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
