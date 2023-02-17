import 'package:flutter/material.dart';
import 'package:notes/core/themes/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final bool inProcess;
  Function()? onPressed;

  CustomButton({super.key,
    required this.text,
    required this.onPressed,
    this.inProcess =false,
  });

  @override
  Widget build(BuildContext context) {
    return inProcess ?const Center(child:  CircularProgressIndicator(color: pinkClr,)): Container(
        margin: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
        decoration: const BoxDecoration(
          // color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            gradient: LinearGradient(colors: [
              bluishClr,
              pinkClr,
            ],
              begin: AlignmentDirectional.centerStart,
              end: AlignmentDirectional.centerEnd,

            )),
        width: double.infinity,
        child: MaterialButton(
            onPressed:onPressed,
            child: Text(
              text,
              style: const TextStyle(
                color: offWhite,
                fontWeight: FontWeight.w900,
                fontSize: 15,
                letterSpacing: 2,
              ),
            )));
  }
}
