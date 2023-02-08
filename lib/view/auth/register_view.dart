import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formRegisterKey = GlobalKey<FormState>();

  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
             // Get.off(LoginView());
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
        ),
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
                  // key: _formRegisterKey,
                  child: Column(
                    children: [
                      const CustomText(text: "Sign Up", fontSize: 30),
                      SizedBox(
                        height: 40,
                      ),
                      CustomTextFormField(
                        text: "Name",
                        hint: "gen-islam",
                        onSave: (value) {
                         // controller.name = value!;
                        },
                        validator: (value) {
                           return value!.isEmpty ? "Name must be filled" : null;
                        },
                      ),
                      SizedBox(
                        height: 40,
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
                        // obscureText: controller.hidePass,
                        onSave: (value) {
                          // controller.password = value!;
                        },
                        validator: (value) {
                          // return value!.isEmpty
                          //     ? "Password must be filled"
                          //     : null;
                        },
                        suffixIcon: IconButton(
                          color: Colors.green,
                          icon: Icon(
                            controller.passwordIcon(),
                          ),
                          onPressed: () {
                            // controller.showHidePassword();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomButton(
                        // inProcess: controller.inProcess,
                        onPress: () {
                          // _formRegisterKey.currentState!.save();
                          // if (_formRegisterKey.currentState!.validate()) {
                          //   // controller.signUpWithEmailAndPassword();
                          // }
                        },
                        text: 'SIGN UP',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
