import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/components/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// void UserRegister()async{
// }
class _RegisterPageState extends State<RegisterPage> {
  String email = '';
  String name = '';
  String password = '';
  String confirmpassword = '';

  final usermailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  int currentStep = 0;
  Color c1 = const Color(0xFF42A5F5);
  late MaterialStateProperty<Color> connectorColor =
      MaterialStateProperty.all<Color>(
          Colors.black); // Initialize connectorColor with a default color

  continueStep() {
    final isLastStep = currentStep == getSteps().length - 1;

    if (isLastStep) {
      print('Complete');
    } else {
      setState(() {
        currentStep += 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(context, details) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: details.onStepContinue,
          child: const Text('Next'),
        ),
        OutlinedButton(
            onPressed: details.onStepCancel, child: const Text('Back'))
      ],
    );
  }

  List<Step> getSteps() => [
        //Account - Step 1
        Step(
            title: const SizedBox.shrink(),
            isActive: currentStep != 1 && currentStep != 2,
            content: Column(
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
                const SizedBox(height: 15),
                MyTextField(
                  controller: usernameController,
                  hintText: 'FullName',
                  obscureText: false,
                  prefixIcon: Icons.person,
                  onChanged: (value) {
                    // Lưu giá trị email mới được nhập
                    email = value;
                  },
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: false,
                  prefixIcon: Icons.lock,
                  onChanged: (value) {
                    // Lưu giá trị email mới được nhập
                    email = value;
                  },
                ),
                const SizedBox(height: 15),
                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: false,
                  prefixIcon: Icons.email,
                  onChanged: (value) {
                    // Lưu giá trị email mới được nhập
                    email = value;
                  },
                )
              ],
            )),
        //Profile - Step 2
        Step(
            title: const SizedBox.shrink(),
            isActive: currentStep != 0 && currentStep != 2,
            content: Column(
              children: [
                MyTextField(
                  controller: usernameController,
                  hintText: 'Enter your email',
                  obscureText: false,
                  prefixIcon: Icons.email,
                  onChanged: (value) {
                    // Lưu giá trị email mới được nhập
                    email = value;
                  },
                )
              ],
            )),
        //Education - Step 3
        Step(
            title: const SizedBox.shrink(),
            isActive: currentStep != 0 && currentStep != 1,
            content: Column(
              children: [
                MyTextField(
                  controller: usernameController,
                  hintText: 'Enter your email',
                  obscureText: false,
                  prefixIcon: Icons.email,
                  onChanged: (value) {
                    // Lưu giá trị email mới được nhập
                    email = value;
                  },
                )
              ],
            )),
      ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: const Color(0xffFAFAFA),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 40.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      Text('Create an account',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: const Color(0xff7D1F1F),
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          )),
                      const SizedBox(height: 10),
                      Text('Create an account to manage yout account today',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                          )),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 500,
                        child: Stepper(
                          type: StepperType.horizontal,
                          elevation: 0,
                          currentStep: currentStep,
                          onStepContinue: continueStep,
                          onStepCancel: cancelStep,
                          onStepTapped: onStepTapped,
                          controlsBuilder: controlsBuilder,
                          steps: getSteps(),
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
