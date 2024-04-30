import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/bloC/profile_status/profile_status_cubit.dart';
import 'package:kltn_mobile/components/actiontab_stepper.dart';
import 'package:kltn_mobile/components/id_tab.dart';
import 'package:kltn_mobile/components/actiontab_result.dart';
import 'package:kltn_mobile/Model/user_login.dart';

class StatusTest extends StatelessWidget {
  final UserAuthLogin userAuth;
  const StatusTest({super.key, required this.userAuth});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ProfileStatusCubit()..updateStatus(userAuth.student?.status ?? 'N/A'),
      child: BlocBuilder<ProfileStatusCubit, ProfileStatusState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
              color: const Color(0xffd9d9d9),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.08),
                  //UserID and UserName
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IdTab(
                        userName: userAuth.name ?? 'N/A',
                        idUser: userAuth.student?.studentCode ?? 'N/A',
                        avatarImgPath: 'assets/Bckgr_Login.jpg',
                      ),
                    ], // parameters userName+idUser and avatarUser
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  //Stepper
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Stepper auto generate step 2
                      ActionTabStepper(
                        header: 'Profile Status',
                        stepTexts: const [
                          'Application has been submitted',
                          'Awaiting review',
                          'Done'
                        ],
                        status: userAuth.student?.status ?? 'N/A'
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  //Result Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActiontabResult(
                        result: userAuth.student?.status ?? 'N/A'
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
