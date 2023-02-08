import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/view/auth/register_view.dart';

import '../../core/view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formLogInKey = GlobalKey<FormState>();

  LoginView({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50.0,
            right: 20.0,
            left: 20.0,
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 10,
                  right: 10,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Form(
                  // key: _formLogInKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomText(text: "Welcome", fontSize: 30),
                          CustomTextButton(
                              text: "Sign Up",
                              onPressed: () {
                                Get.to(()=>RegisterView());
                              },
                              textColor: Colors.green,
                              fontSize: 18),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const CustomText(
                        text: "Sign in to Continue",
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextFormField(
                        text: "Email",
                        hint: "gen_eslam2002@gmail.com",
                        onSave: (value) {},
                        validator: (value) {},
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        text: "Password",
                        hint: "*********",
                        onSave: (value) {},
                        validator: (value) {},
                        suffixIcon: IconButton(
                          color: Colors.green,
                          icon: Icon(Icons.add),
                          onPressed: () {},
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            text: "Forget Password?",
                            fontSize: 14,
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        onPress: () {},
                        text: 'SIGN IN',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
