import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kltn_mobile/blocs/contact_us_bloc/contact_cubit.dart';
import 'package:kltn_mobile/blocs/contact_us_bloc/contact_state.dart';
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
import 'package:kltn_mobile/screens/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

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
  String? errorTitleMessage, errorEmailMessage;

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
    context.read<ContactUsCubit>().getSchools();

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
  void sendForm() async {
    String email = emailController.text.trim(),
        name = fullNameController.text.trim(),
        phone = phoneController.text.trim(),
        message = messageController.text.trim();

    // Check if any of the fields are null or empty
    var items = {
      'School': selectedSchool,
      'valuetitleForm': valueTitleForm,
      'email': email,
      'name': name,
      'phone': phone,
      'message': message
    };
    items.forEach((key, value) {
      if (value == null || (value is String && value.isEmpty)) {
        print('$key is null or empty');
      }
    });

    if (selectedSchool == null ||
        valueTitleForm == null ||
        email.isEmpty ||
        name.isEmpty ||
        phone.isEmpty ||
        message.isEmpty) {
      print('Please fill all fields correctly.');
      return;
    }

    context
        .read<ContactUsCubit>()
        .sendForm(name, email, valueTitleForm!, phone, message, selectedSchool);
  }

  //Declare intial state value for selectedSchool ,program, city, district, ward
  void schoolChange(Schools? school) {
    setState(() {
      if (school != null) {
        selectedSchool = school.id;
      }
    });
  }

  //Declar intial state value for TitleFprm -Function TitleForm
  void titleValueChanged(TitleForm? title) {
    setState(() {
      print("TitleForm: $title");
      if (title != null) {
        valueTitleForm = title;
        print("titleform: $title");
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

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        context.watch<ThemeSettingCubit>().state == AppTheme.blackTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<ContactUsCubit, ContactUsState>(
      listener: (context, state) {
        if (state is ContactErrorTitleErrorState) {
          setState(() {
            errorTitleMessage = state.error;
          });
        } else if (state is ContactErrorEmailState) {
          setState(() {
            errorEmailMessage = state.error;
          });
        } else if (state is ContactSuccessState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        }
      },
      builder: (context, state) {
        if (state is ContactErrorState) {
          Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        } else if (state is ContactLoadingState) {
          const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ContactInitialState) {}
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
                      child: BlocBuilder<ContactUsCubit, ContactUsState>(
                        builder: (context, state) {
                          if (state is ContactLoadedNamedSchoolState) {
                            lstschools = state.school;
                          }
                          return DropdownCustom<Schools>(
                            icon: Icons.school,
                            items: lstschools,
                            selectedItem: selectedSchool == null
                                ? null
                                : lstschools.firstWhereOrNull((element) =>
                                    element.id.toString() == selectedSchool),
                            onChanged: (Schools? newValueSchool) {
                              setState(() {
                                selectedSchool = newValueSchool?.id.toString();
                                schoolChange(newValueSchool);
                              });
                            },
                            itemLabel: (Schools school) => school.name,
                            hintText: 'Select a school',
                            isExpanded: true,
                          );
                        },
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
                    errorText: errorEmailMessage,
                    color: AppColor.scafflodBgColor,
                    //errorText: errorEmail,
                    onChanged: (value) {
                      email = value;
                      context.read<ContactUsCubit>().checkEmail(value);
                      if (email.isEmpty) {
                        setState(() {
                          errorEmailMessage;
                        });
                      } else {
                        setState(() {
                          errorEmailMessage = null;
                        });
                      }
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
                      print('Button pressed');
                      sendForm();
                    },
                    text: 'Send inquiry',
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
