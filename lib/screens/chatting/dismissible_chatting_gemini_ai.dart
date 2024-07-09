import 'package:flutter/material.dart';
import 'package:kltn_mobile/screens/chatting/chatting_gemini_ai.dart';

class DismissibleBottomSheetView extends StatelessWidget {
  final Widget childView;

  const DismissibleBottomSheetView({super.key, required this.childView});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 60),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: GeminiAI(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
