import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/blocs/theme_setting_cubit/theme_setting_cubit.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/constant/theme.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/dropdown.dart';
import 'package:kltn_mobile/components/functions/textfield_title.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';
import 'package:kltn_mobile/models/enum.dart';
import 'package:kltn_mobile/models/schools.dart';
import 'package:kltn_mobile/screens/home/base_lang.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends BasePage {
  const ContactUs({super.key});

  get error => null;

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends BasePageState<ContactUs> {
  //Declare
  String email = '', fullName = '', phone = '', message = '';
  Schools? selectedSchoolObject;
  String? selectedSchool;
  TitleForm? valueTitleForm;

  //Declare API School
  List<Schools> lstschools = [];
  String? errorTitleMessage;

  //Declare controller
  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final titleFormController = DropdownButtonFormField;
  final schoolController = DropdownButtonFormField;

  //------------
  //darkmode

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

  //------
  //Declare
  void titleValueChanged(TitleForm? newValueTitle) {
    setState(() {
      print("TitleForm: $newValueTitle");
      if (newValueTitle != null) {
        valueTitleForm = newValueTitle;
        print("titleform: $valueTitleForm");
      }
    });
  }

  String getTitleFormLabel(BuildContext context, TitleForm titleForm) {
    switch (titleForm) {
      case TitleForm.BILLING:
        return Intl.message(
          'Billing',
          name: 'Billing',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.FEEDBACK:
        return Intl.message(
          'Feedback',
          name: 'Feedback',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.PROCEDURE:
        return Intl.message(
          'Procedure',
          name: 'Procedure',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.REFUND:
        return Intl.message(
          'Refund',
          name: 'Refund',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.SCHOLARSHIP:
        return Intl.message(
          'Scholarship',
          name: 'Scholarship',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.SUBSCRIPTION:
        return Intl.message(
          'Subscription',
          name: 'Subscription',
          locale: Localizations.localeOf(context).languageCode,
        );
      case TitleForm.SYSTEM:
        return Intl.message(
          'System',
          name: 'System',
          locale: Localizations.localeOf(context).languageCode,
        );
      default:
        return '';
    }
  }

  void schoolChange(Schools? school) {
    setState(() {
      if (school != null) {
        selectedSchoolObject = school;
        selectedSchool = school.name;
      }
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
              //TitleForm
              SizedBox(
                width: screenWidth * 0.85,
                height: 60,
                child: DropdownCustom<TitleForm>(
                  icon: Icons.title,
                  items: TitleForm.values,
                  selectedItem: valueTitleForm,
                  hintText: 'Select a title form',
                  onChanged: (TitleForm? newValueTitle) {
                    if (newValueTitle != null) {
                      setState(() {
                        errorTitleMessage;
                      });
                    } else {
                      setState(() {
                        errorTitleMessage = null;
                      });
                    }
                    setState(() {
                      titleValueChanged(newValueTitle);
                      print(valueTitleForm);
                    });
                  },
                  itemLabel: (TitleForm title) =>
                      getTitleFormLabel(context, title),
                  isExpanded: false,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                  width: screenWidth * 0.85,
                  height: 60,
                  child: DropdownCustom<Schools>(
                    icon: Icons.school,
                    items: lstschools,
                    selectedItem: selectedSchool == null
                        ? null
                        : lstschools.firstWhere(
                            (element) => element.name == selectedSchool),
                    onChanged: (Schools? newValueSchool) {
                      setState(() {
                        schoolChange(newValueSchool);
                      });
                    },
                    itemLabel: (Schools school) => school.name,
                    hintText: 'Select a school',
                    isExpanded: true,
                  )),
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
