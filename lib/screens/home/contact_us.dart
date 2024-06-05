import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/functions/button.dart';
import 'package:kltn_mobile/components/functions/textfield_title.dart';
import 'package:kltn_mobile/components/style/backbutton.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String email = '', fullName = '', phone = '', message = '';

  final emailController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scafflodBgColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
        child: Center(
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
                    color: AppColor.redButton,
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 5),
              const TextMonserats(
                'Need assistance? Drop us a message, describing the problem you’re experiencing.',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 50),
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
              const SizedBox(height: 50),
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
