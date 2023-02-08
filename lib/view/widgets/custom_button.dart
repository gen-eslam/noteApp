import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPress;
  final String text;
  final Color textColor;
  final Alignment textAlignment;
  final double fontSize;
  final double borderRadius;
  final double padding;
  final Color backgroundColor;
  final bool inProcess;

  const CustomButton(
      {super.key,
      required this.onPress,
      required this.text,
      this.textColor = Colors.white,
      this.textAlignment = Alignment.center,
      this.fontSize = 16,
      this.borderRadius = 10,
      this.padding = 18,
        this.inProcess =false,
      this.backgroundColor = Colors.green});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        padding: MaterialStateProperty.all(EdgeInsets.all(padding)),
        backgroundColor: MaterialStateProperty.all(inProcess? Colors.white:backgroundColor),
      ),
      child:inProcess ?const CircularProgressIndicator(color: Colors.green,):CustomText(
        text: text,
        alignment: textAlignment,
        color: Colors.white,
        fontSize: fontSize,
      ),
    );
  }
}


