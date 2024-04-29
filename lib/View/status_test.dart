import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/actiontab_stepper.dart';
import 'package:kltn_mobile/components/id_tab.dart';
import 'package:kltn_mobile/components/actiontab_result.dart';

class StatusTest extends StatefulWidget {
  const StatusTest({super.key});

  @override
  State<StatusTest> createState() => _StatusState();
}

class _StatusState extends State<StatusTest> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: const Color(0xffd9d9d9),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.08),
            //UserID and UserName
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IdTab(
                  userName: 'John Doe',
                  idUser: '24PT1112423',
                  avatarImgPath: 'assets/Bckgr_Login.jpg',
                ),
              ], // parameters userName+idUser and avatarUser
            ),
            SizedBox(height: screenHeight * 0.03),

            //Stepper
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Stepper auto generate step 2
                ActionTabStepper(
                  header: 'Profile Status',
                  stepTexts: [
                    'Application has been submitted',
                    'Awaiting review',
                    'Done'
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            //Result Status
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActiontabResult(
                  result: 'Pending',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
