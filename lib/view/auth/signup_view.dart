import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/auth_view_model.dart';

import '../../core/themes/theme.dart';
import '../../core/themes/theme_services.dart';
import '../../core/utils/constance.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpView extends GetWidget<AuthViewModel> {
  SignUpView({super.key});

  final GlobalKey<FormState> _formSignupKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: _appBar(context),
      body: _body(context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          controller.clearController();
          controller.suffixConfirmPassIcon = null;
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios),
        color: pinkClr,
      ),
      title: Constance.appText(context,"Note"," App"),
      actions: [
        IconButton(
          onPressed: () {
            ThemeService().switchTheme();
          },
          icon: Icon(Get.isDarkMode ? Icons.nightlight : Icons.sunny),
          color: pinkClr,
        )
      ],
    );
  }

  _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          top: Get.height / 5,
          right: 20.0,
          left: 20.0,
        ),
        child: Form(
          key: _formSignupKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomTextFormField(
                controller: controller.name,
                textInputType: TextInputType.name,
                hintText: "Name",
                iconData: Icons.person,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Name Must Be filled";
                  }
                },
                onSave: (value) {
                  controller.name.text = value!;
                },
              ),
              CustomTextFormField(
                controller: controller.email,
                textInputType: TextInputType.emailAddress,
                hintText: "EMAIL",
                iconData: Icons.email,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email Must Be filled";
                  } else if (!GetUtils.isEmail(controller.email.text)) {
                    return "Invalid Email";
                  }
                },
                onSave: (value) {
                  controller.email.text = value!;
                },
              ),
              GetBuilder<AuthViewModel>(builder: (logic) {
                return CustomTextFormField(
                  controller: controller.password,
                  textInputType: TextInputType.visiblePassword,
                  hintText: "PASSWORD",
                  iconData: Icons.password,
                  obscureText: controller.hidePass,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.passwordIcon(),
                      color: pinkClr,
                    ),
                    onPressed: () {
                      controller.showHidePassword();
                    },
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Must Be filled";
                    }
                  },
                  onSave: (value) {
                    controller.password.text = value!;
                  },
                );
              }),
              GetBuilder<AuthViewModel>(builder: (logic) {
                return CustomTextFormField(
                  controller: controller.confirmPassword,
                  textInputType: TextInputType.visiblePassword,
                  hintText: "CONFIRM PASSWORD",
                  iconData: Icons.password,
                  obscureText: controller.hidePass,
                  suffixIcon: controller.suffixConfirmPassIcon,

                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Confirm Password Must Be filled";
                    } else if (controller.suffixConfirmPassIcon == null) {
                      return "Confirm Password Must Be Equal Password";
                    }
                  },
                  onChange: (value) {
                    controller.isEqual();
                  },
                  onSave: (value) {
                    controller.confirmPassword.text = value!;
                  },
                );
              }),
              GetBuilder<AuthViewModel>(builder: (logic) {
                return CustomButton(text: "Signup",
                    inProcess: controller.inProcess,
                    onPressed: () {
                  _formSignupKey.currentState!.save();
                  if (_formSignupKey.currentState!.validate()) {
                    controller.signupWithEmailAndPassword();
                  }
                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
