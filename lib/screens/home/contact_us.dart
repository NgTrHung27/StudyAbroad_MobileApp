import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/dropdown.dart';
import 'package:kltn_mobile/components/functions/textfield_title.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends BasePage {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends BasePageState<ContactUs> {
  String email = '', fullName = '', phone = '', message = '';

  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  bool isChangeColor = false;
  @override
  void initState() {
    super.initState();
    _loadIconState();
  }

  Future<void> _loadIconState() async {
    final prefs = await SharedPreferences.getInstance();
    isChangeColor = prefs.getBool('isChangeColor') ?? false;
    setState(() {});
  }

  void toggleTheme() {
    context.read<ThemeSettingCubit>().toggleTheme();
    setState(() {
      isChangeColor = !isChangeColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.watch<ThemeSettingCubit>().state == AppTheme.blackTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: context.select(
          (ThemeSettingCubit cubit) => cubit.state.scaffoldBackgroundColor),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 50),
              Row(
                children: [
                  BackButtonCircle(onPressed: () {
                    Navigator.pop(context);
                  }),
                  const Spacer(flex: 1),
                  TextMonserats(
                    'Contact Us',
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: isDarkMode ? Colors.white : AppColor.redButton,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 6),
              const TextMonserats(
                'Need assistance? Drop us a message, describing the problem you’re experiencing.',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: screenWidth * 0.85,
                height: 60,
                child: DropdownCustom(
                  items: ['General Inquiry', 'Technical Support', 'Feedback'],
                  selectedItem: 'General Inquiry',
                  hintText: 'Select a title',
                  onChanged: (value) {
                    // Your onChanged logic here
                  },
                  itemLabel: (value) => value,
                  isExpanded: true,
                  icon: null,
                  color: AppColor.scafflodBgColor,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: screenWidth * 0.85,
                height: 60,
                child: DropdownCustom(
                  items: ['General Inquiry', 'Technical Support', 'Feedback'],
                  selectedItem: 'General Inquiry',
                  hintText: 'Select a school',
                  onChanged: (value) {
                    // Your onChanged logic here
                  },
                  itemLabel: (value) => value,
                  isExpanded: true,
                  icon: null,
                  color: AppColor.scafflodBgColor,
                ),
              ),
              TextFieldTitle(
                title: 'Full Name',
                controller: fullNameController,
                hintText: 'Enter your full name',
                color: AppColor.scafflodBgColor,
                onChanged: (value) {
                  fullName = value;
                },
              ),
              const SizedBox(height: 10),
              TextFieldTitle(
                title: 'Email',
                controller: emailController,
                hintText: 'Enter your email',
                color: AppColor.scafflodBgColor,
                onChanged: (value) {
                  email = value;
                },
              ),
              const SizedBox(height: 10),
              TextFieldTitle(
                title: 'Phone',
                controller: phoneController,
                hintText: 'Enter your phone number',
                color: AppColor.scafflodBgColor,
                onChanged: (value) {
                  phone = value;
                },
              ),
              const SizedBox(height: 10),
              TextFieldTitle(
                title: 'How can we help?',
                controller: messageController,
                hintText: 'Enter your message',
                color: AppColor.scafflodBgColor,
                onChanged: (value) {
                  message = value;
                },
              ),
              const SizedBox(height: 40),
              MyButton(
                onTap: () {
                  // Your onTap logic here
                },
                text: 'Send inquiry',
              )
            ],
          ),
        ),
      ),
    );
  }
}
