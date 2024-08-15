import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/backbutton.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions/textfield_title.dart';

class Respond extends StatefulWidget {
  const Respond({super.key});

  @override
  State<Respond> createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.select(
        (ThemeSettingCubit cubit) => cubit.state.brightness == Brightness.dark);

    final screenHeight = MediaQuery.of(context).size.height;
    final TextEditingController contentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.redButton,
        toolbarHeight: screenHeight * 0.09,
        title: Row(
          children: [
            BackButtonCircle(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Expanded(
              child: Center(
                child: TextMonserats(
                  'Respond',
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Container(
              color: isDarkMode
                  ? AppColor.scafflodBgColorDark
                  : Colors.white, //backscreen color
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextMonserats(
                    'Respond',
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  TextMonserats(
                    'Respond Request',
                    fontSize: 23,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(height: 20),
                  TextFieldTitle(
                    title: 'Content',
                    controller: contentController,
                    hintText: 'Enter your content',
                    color: Colors.white,
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),
                  SimpleButton(
                    backgroundColor: Colors.transparent,
                    borderColor: isDarkMode ? Colors.white : AppColor.redButton,
                    onPressed: () {
                      // Respond
                    },
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.upload_file,
                            size: 21,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 10),
                          TextMonserats(
                            'Upload file here',
                            color: isDarkMode ? Colors.white : Colors.black,
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
