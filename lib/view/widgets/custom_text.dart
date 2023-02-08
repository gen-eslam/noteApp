import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Alignment alignment;
  final int maxLine;
  final FontWeight fontWeight;
  final double height;

  const CustomText(
      {super.key, this.text = '',
      this.color = Colors.black,
      this.fontSize = 16,
        this.maxLine =2,
        this.height =1,
        this.fontWeight=FontWeight.normal,
      this.alignment = Alignment.bottomLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLine,
        overflow: TextOverflow.ellipsis,

        style: TextStyle(color: color, fontSize: fontSize,fontWeight:fontWeight,height: height ),
      ),
    );
  }
}
