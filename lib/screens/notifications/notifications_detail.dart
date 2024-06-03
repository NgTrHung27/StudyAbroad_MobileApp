import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions/circle_avatarimg.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/models/notifications.dart';

class NotificationDetailPage extends StatelessWidget {
  final Notifications notification;

  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.07, vertical: screenHeight * 0.05),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                BackButtonCircle(),
                CirleAvatarImage(avatarImgPath: 'assets/backgr-01.jpg'),                
              ]
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: isDarkMode ? const Color(0xff3F3F46) : Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(notification.schoolAvt ?? 'assets/backgr-01.jpg'),
                            ),
                            SizedBox(
                              width: screenWidth * 0.05,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextMonserats(
                                  notification.schoolName ?? '',
                                  color: isDarkMode ? Colors.white : AppColor.redButton,
                                  fontSize: screenWidth*0.04,
                                  fontWeight: FontWeight.w600,
                                ),
                                TextMonserats(
                                  notification.time ?? '',
                                    color: isDarkMode ? Colors.white : Colors.black,
                                    fontSize: screenWidth*0.03,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              TextMonserats(
                                notification.notiTitle ?? '',
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              TextMonserats(
                                notification.notiContent ?? '',
                                  color: isDarkMode ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                ),
                            ],
                          ),
                        )
                    ],
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}