import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';

class StepperDemo extends StatefulWidget {
  final String header; // Thêm tham số tiêu đề
  final List<String> titles;
  final List<Widget> contents;

  const StepperDemo({
    super.key,
    required this.header,
    required this.titles,
    required this.contents,
  });

  @override
  // ignore: library_private_types_in_public_api
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(
          primary: AppColor.redButton,
        ),
      ),
      child: SizedBox(
        height: 500.0, // Đặt chiều cao cố định cho toàn bộ Stepper
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0), // Khoảng cách từ các cạnh
              child: Text(
                widget.header,
                style: TextStyle(
                  fontSize: 20.0, // Kích thước chữ tiêu đề
                  fontWeight: FontWeight.bold,
                  color: AppColor.redButton, // Màu chữ tiêu đề
                ),
              ),
            ),
            Expanded(
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (step) {
                  setState(() {
                    _currentStep = step;
                  });
                },
                controlsBuilder:
                    (BuildContext context, ControlsDetails details) {
                  return const SizedBox
                      .shrink(); // Tắt nút 'Continue' và 'Cancel'
                },
                steps: List<Step>.generate(
                  widget.titles.length,
                  (index) => Step(
                    title: Text(
                      widget.titles[index],
                      style: TextStyle(
                        color: _currentStep == index
                            ? AppColor.redButton
                            : Colors.grey, // Màu sắc tiêu đề bước
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0, // Kích thước chữ tiêu đề bước
                      ),
                    ),
                    content: Align(
                      alignment: Alignment
                          .centerLeft, // Căn chỉnh nội dung với tiêu đề
                      child: SizedBox(
                        width: double.infinity, // Chiếm toàn bộ chiều rộng
                        child: widget.contents[index],
                      ),
                    ),
                    isActive: _currentStep >= index,
                    state: _currentStep > index
                        ? StepState.complete
                        : StepState.indexed,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
