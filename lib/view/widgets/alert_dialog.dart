import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/themes/theme.dart';

// ignore: must_be_immutable
class AlertDialogWidget extends StatelessWidget {
  String? contentText;
  Function()? confirmFunction, declineFunction;

  AlertDialogWidget(
      {super.key,
      required this.contentText,
      required this.confirmFunction,
      required this.declineFunction});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 12,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        children: const [
          Icon(
            Icons.warning,
            color: Colors.amber,
          ),
          Text("warning"),
        ],
      ),
      content: Text(
        contentText!,
      ),
      actions: [
        TextButton(
            onPressed: confirmFunction,
            child: Text(
              "yes",
              style: TextStyle(
                  color: Get.isDarkMode ? pinkClr : bluishClr,
                  fontWeight: FontWeight.bold),
            )),
        TextButton(
            onPressed: declineFunction,
            child: Text(
              "no",
              style: TextStyle(
                  color: Get.isDarkMode ? pinkClr : bluishClr,
                  fontWeight: FontWeight.bold),
            )),
      ],
    );
  }
}
