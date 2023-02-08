import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomTextButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final double fontSize;
  final Function()? onPressed;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.black,
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: fontSize,

          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          foregroundColor: Colors.green,
        ),
        child: Text(
          text,
          style: TextStyle(color:textColor),
        ));
  }
}
