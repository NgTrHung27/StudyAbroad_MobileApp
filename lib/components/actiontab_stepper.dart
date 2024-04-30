import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kltn_mobile/bloC/profile_status/profile_status_cubit.dart';

class ActionTabStepper extends StatelessWidget {
  final String header; // parameter header
  final List<String> stepTexts;
  final String status;

  const ActionTabStepper({
    super.key,
    required this.header,
    required this.stepTexts,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileStatusCubit, ProfileStatusState>(
      builder: (context, state) {
        int currentStep = (state is ProfileStatusLoaded && state.status == status) ? state.currentStep : 0;
        print(status);
        return SingleChildScrollView(
          child: Container(
            width: screenWidth * 0.9,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    header,
                    style: GoogleFonts.montserrat(
                      fontSize: 17,
                      color: const Color(0xff7D1F1F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stepper(
                        currentStep: currentStep,
                        onStepTapped: (step) => {}, // Add your logic here
                        controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                        return Container();
                        },
                        steps: List.generate(
                          stepTexts.length,
                          (index) => Step(
                            title: Text(
                              stepTexts[index],
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: const Color(0xff7D1F1F),
                              ),
                            ),
                            content: Container(),
                            isActive: currentStep >= index,
                            state: currentStep == index
                                ? StepState.indexed
                                : currentStep > index
                                    ? StepState.complete
                                    : StepState.indexed,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
