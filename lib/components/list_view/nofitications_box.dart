import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/models/notifications.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart'; 

class NotificationBox extends BasePage {
  final Notifications notification;

  const NotificationBox({super.key, required this.notification});

  @override
  NotificationBoxState createState() => NotificationBoxState();
}

class NotificationBoxState extends State<NotificationBox> {
  late ThemeSettingCubit themeSettingCubit; // Declare ThemeSettingCubit
  late bool isDarkMode; // Declare isDarkMode

  @override
  void initState() {
    super.initState();
    themeSettingCubit = context.read<ThemeSettingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);
    final textColorRed = isDarkMode ? Colors.white : AppColor.redButton;
    final titleAndTimeColor = isDarkMode ? Colors.white : Colors.black;
    final boxColor = isDarkMode ? const Color(0xff3F3F46) : Colors.white;


    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: screenWidth,
        height: 100,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: boxColor, // Use isDarkMode to set the background color
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start, // Distribute the space evenly between the columns
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(widget.notification.schoolAvt ?? ''),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Align the text to the left
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute the space evenly between the columns
                            children: [
                                TextMonserats(widget.notification.schoolName ?? '', color: textColorRed, fontSize: 14,),
                                TextMonserats(widget.notification.time ?? '', fontSize: 11, color: titleAndTimeColor, fontWeight: FontWeight.w500), // Use the TextMonserats widget and set the maxLine to 1
                            ],
                          ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: TextMonserats(widget.notification.notiTitle ?? '', fontWeight: FontWeight.w500, color: titleAndTimeColor, fontSize: 11,),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}