import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/Style/montserrat.dart';
import 'package:kltn_mobile/components/Style/simplebutton.dart';
import 'package:kltn_mobile/View/Authentication/register_page.dart';


Widget controlsBuilder(context, details) {
  int currentStep = 1;
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: currentStep == 2 // Kiểm tra nếu đang ở bước thứ 3
        ? Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 40,
                child: SimpleButton(
                  backgroundColor: Colors.transparent,
                  borderColor: const Color(0xff7D1F1F),
                  onPressed: details.onStepCancel,
                  child: const TextMonserats(
                    'Back',
                    color: Color(0xff7D1F1F),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: SimpleButton(
                    onPressed: () {
                      context.read<RegisterPage>().userRegister;
                    },
                    child: const TextMonserats(
                      'Sign Up',
                      color: Colors.white,
                    ),
                  )),
            ],
          )
        : Row(
            children: [
              Expanded(
                child: SimpleButton(
                  backgroundColor: Colors.transparent,
                  borderColor: const Color(0xff7D1F1F),
                  onPressed: details.onStepCancel,
                  child: const TextMonserats(
                    'Back',
                    color: Color(0xff7D1F1F),
                  ),
                ),
              ),
              const SizedBox(width: 120),
              Expanded(
                child: SimpleButton(
                  onPressed: details.onStepContinue,
                  child: const TextMonserats(
                    'Next',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
  );
}
