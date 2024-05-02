import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final VoidCallback onPressed;
  final Widget child;

  const SimpleButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            backgroundColor ?? const Color(0xff7D1F1F)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: borderColor ?? Colors.transparent),
          ),
        ),
        overlayColor: MaterialStateProperty.resolveWith<Color>((states) =>
            states.contains(MaterialState.pressed)
                ? (backgroundColor ?? const Color(0xff7D1F1F)).withOpacity(0.2)
                : (backgroundColor ?? const Color(0xff7D1F1F))
                    .withOpacity(0.1)),
        shadowColor: MaterialStateProperty.resolveWith<Color>((states) =>
            states.contains(MaterialState.pressed)
                ? Colors.black.withOpacity(0.3)
                : Colors.transparent),
        elevation: MaterialStateProperty.resolveWith<double>(
            (states) => states.contains(MaterialState.pressed) ? 5.0 : 0.0),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
