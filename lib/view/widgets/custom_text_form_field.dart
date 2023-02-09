import 'package:flutter/material.dart';

import '../../core/themes/theme.dart';

class CustomTextFormField extends StatelessWidget {
  final TextInputType textInputType;
  final String hintText;
  final Widget? suffixIcon;
  final IconData iconData;
  final bool obscureText;
  final String? errorText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String?)? onSave;
  final Function(String?)? onChange;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.textInputType,
    required this.iconData,
    required this.controller,
    this.errorText,
    required this.validator,
    this.obscureText = false,
    required this.onSave,
    this.onChange,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            maxLines: 1,
            controller: controller,
            keyboardType: textInputType,
            obscureText: obscureText,
            onSaved: onSave,
            validator:validator ,
            onChanged: onChange,
            decoration: InputDecoration(
                hintText: hintText,
                hintStyle: textHintTheme(context, 15).copyWith(
                  letterSpacing: 3,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: bluishClr,
                    width: 1.5,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: bluishClr,
                    width: 1.5,
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: bluishClr,
                    width: 1.5,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  borderSide: BorderSide(
                    color: bluishClr,
                    width: 1.5,
                  ),
                ),

                prefixIcon: Icon(
                  iconData,
                  color: bluishClr,
                ),
                suffixIcon: suffixIcon,
                suffixIconColor: pinkClr,
                errorStyle: const TextStyle(
                  color: pinkClr,
                  fontStyle: FontStyle.italic,
                )),
          ),
        ],
      ),
    );
  }
}
