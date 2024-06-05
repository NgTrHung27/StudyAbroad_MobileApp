import 'package:flutter/material.dart';
import 'package:kltn_mobile/components/constant/color_constant.dart';
import 'package:kltn_mobile/components/style/montserrat.dart';

class TextFieldTitle extends StatefulWidget {
  final String title, hintText;
  final TextEditingController controller;
  final Color color;
  final Null Function(dynamic value) onChanged;

  const TextFieldTitle({
    super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.color = Colors.white,
  });

  @override
  State<TextFieldTitle> createState() => _TextFieldTitleState();
}

class _TextFieldTitleState extends State<TextFieldTitle> {
  late FocusNode _focusNode;
  Null Function(dynamic value)? onChanged;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isFocused = _focusNode.hasFocus;

    return SizedBox(
      width: screenWidth * 0.85,
      child: Stack(
        children: <Widget>[
          Container(
            height: 65.0,
            constraints: const BoxConstraints(minWidth: double.infinity),
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.borderTextField, width: 1.0),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: AppColor.borderTextField, fontSize: 16),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 15.0), // Adjust the padding here
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 15.0,
            child: Container(
              color: widget.color,
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: TextMonserats(
                widget.title,
                color: isFocused ? Colors.black : AppColor.borderTextField,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
