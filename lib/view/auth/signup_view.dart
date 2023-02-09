import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/view_model/auth_view_model.dart';

import '../../core/themes/theme.dart';
import '../../core/themes/theme_services.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class SignUpView extends GetWidget<AuthViewModel> {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign",
            style: textAppBarTheme(context).copyWith(
              letterSpacing: 2.5,
              color: bluishClr,
            ),
          ),
          Text(" Up",
              style: textAppBarTheme(context)
                  .copyWith(letterSpacing: 2.5, color: pinkClr)),
        ],
      ),
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
      physics: const NeverScrollableScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.only(
          top: Get.height / 5,
          right: 20.0,
          left: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomTextFormField(
              controller: controller.name,
              textInputType: TextInputType.name,
              hintText: "Name",
              iconData: Icons.person,
              validator: (value) {},
              onSave: (value) {
                controller.name.text = value!;
              },
            ),
            CustomTextFormField(
              controller: controller.email,
              textInputType: TextInputType.emailAddress,
              hintText: "EMAIL",
              iconData: Icons.email,
              validator: (value) {},
              onSave: (value) {
                controller.email.text = value!;
              },
            ),
            GetBuilder<AuthViewModel>(builder: (logic) {
              return CustomTextFormField(
                controller: controller.password,
                textInputType: TextInputType.visiblePassword,

                ///todo change Controller
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
                validator: (value) {},
                onSave: (value) {
                  // controller.email = value!;
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
                suffixIcon:controller.suffixConfirmPassIcon ,

                validator: (value) {},
                onChange: (value) {
                  controller.isEqual();
                },
                onSave: (value) {},
              );
            }),
            CustomButton(text: "Signup", onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
