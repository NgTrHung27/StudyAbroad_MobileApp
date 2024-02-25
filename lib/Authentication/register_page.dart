import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

// void UserRegister()async{
// }
class _RegisterPageState extends State<RegisterPage> {
  int currentStep = 0;
  continueStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1;
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
        OutlinedButton(onPressed: details.onStepCancel, child: const Text('Back'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 35.0, vertical: 40.0),
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
                        width: 300,
                        height: 500,
                        child: Stepper(
                          type: StepperType.horizontal,
                          currentStep: currentStep,
                          onStepContinue: continueStep,
                          onStepCancel: cancelStep,
                          onStepTapped: onStepTapped,
                          controlsBuilder: controlsBuilder,
                          steps: [
                            Step(
                              title: const Text('Account'),
                              content: const Text('This Step 1'),
                              isActive: currentStep != 1 && currentStep != 2,
                            ),
                            Step(
                              title: const Text('Profile'),
                              content: const Text('This Step 2'),
                              isActive: currentStep != 0 && currentStep != 2,
                            ),
                            Step(
                              title: const Text('Edu'),
                              content: const Text('This Step 3'),
                              isActive: currentStep != 0 && currentStep != 1,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
