import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/text_field.dart';
import 'package:kltn_mobile/components/button.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  String email = '';
  final usermailController = TextEditingController();

   void userForgetPass() async {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: 
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/FORGOT PASSWORD 6.jpg"),
              fit: BoxFit.cover
              )),
        child: Scaffold (
        backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 25.0, vertical: 30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Thay đổi từ CrossAxisAlignment.center thành CrossAxisAlignment.start
                  children: [
                    //Logo
                    //Logo và các phần còn lại sẽ được bao trong một Row để căn giữa theo chiều ngang
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Logo
                        Image.asset(
                          "assets/LOGO_WHITE.png",
                          height: 70,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'Forgot\nPassword?',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),

                    const SizedBox(height: 4),
                    Text(
                      'Enter your email for the verification process, we will send verify link',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 70),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Enter Your Email',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),

                        Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyTextField(
                              controller: usermailController,
                              hintText: 'Email',
                              obscureText: false,
                              prefixIcon: Icons.email,
                              onChanged: (value) {
                                // Lưu giá trị email mới được nhập
                                email = value;
                              },
                            ),
                          ],
                        ),

                      const SizedBox(height: 30),
                      Row( mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyButton(
                          onTap: userForgetPass,
                        ),
                      ],
                      ),

                      const SizedBox(height: 280),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to Login',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ]
                      ),
                    ]
                    ),
                    ]
                    ),
                ),
              ),
            )
        )
      ),
    );
  }
}