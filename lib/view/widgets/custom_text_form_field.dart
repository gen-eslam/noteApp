import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;
  final String hint;
  final Function(String?)? onSave;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.text,
    required this.hint,
    this.onSave,
    this.suffixIcon,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text,
          fontSize: 14,
          color: Colors.grey.shade900,
        ),
        TextFormField(

          onSaved: onSave,
          validator: validator,
          cursorColor: Colors.green,
          obscureText: obscureText,
          keyboardType: textInputType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
            fillColor: Colors.white,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green),
            ),
            suffixIcon: suffixIcon,
            errorStyle:
                const TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}
