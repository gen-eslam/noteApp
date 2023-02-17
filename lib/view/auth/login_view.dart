import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/core/utils/constance.dart';
import 'package:notes/core/view_model/auth_view_model.dart';
import 'package:notes/view/auth/signup_view.dart';
import '../../core/themes/theme.dart';
import '../../core/themes/theme_services.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginView extends GetWidget<AuthViewModel> {
  LoginView({super.key});
  final GlobalKey<FormState> _formLoginKey = GlobalKey<FormState>();

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
      title: Constance.appText(context),
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
          key: _formLoginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                  left: 10,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: textTitleTheme(context).copyWith(
                            color: bluishClr,
                            letterSpacing: 1,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text("Login To Continue",
                            style: textTitleTheme(context).copyWith(
                              letterSpacing: 2.5,
                              color: pinkClr,
                              fontSize: 15,
                            )),
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          controller.clearController();
                          Get.to(SignUpView());
                        },
                        child: Text(
                          "SignUp",
                          style: textTitleTheme(context).copyWith(
                            color: pinkClr,
                            fontWeight: FontWeight.w100,
                          ),
                        ))
                  ],
                ),
              ),
              GetBuilder<AuthViewModel>(builder: (logic) {
                return CustomTextFormField(
                  controller: controller.email,
                  textInputType: TextInputType.emailAddress,
                  hintText: "EMAIL",
                  iconData: Icons.email,
                  onSave: (value) {
                    controller.email.text = value!;
                  },
                  onChange: (value) {
                    // controller.errorEmailText =null;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email Must Be filled";
                    } else if (!GetUtils.isEmail(controller.email.text)) {
                      return "Invalid Email";
                    }
                  },
                );
              }),
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
                  onChange: (value) {},
                  onSave: (value) {
                    controller.password.text = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password Must Be filled";
                    }
                  },
                );
              }),
              GetBuilder<AuthViewModel>(builder: (logic) {
                return CustomButton(
                    text: "Login",
                    inProcess: controller.inProcess,
                    onPressed: () {
                      _formLoginKey.currentState!.save();
                      if (_formLoginKey.currentState!.validate()) {
                        controller.logInWithEmailAndPassword();
                      }
                    });
              }),
              Text(
                "-OR-",
                style: textContentTheme(context).copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  controller.offLineMode();
                },
                child: Text(
                  "Offline Mode",
                  style: textContentTheme(context).copyWith(
                    letterSpacing: 1,
                    color: pinkClr,
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
