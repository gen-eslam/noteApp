import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:notes/core/utils/get_storage.dart';
import 'package:notes/view/home_view.dart';

import '../themes/theme.dart';
import '../utils/constance.dart';

class AuthViewModel extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  bool hidePass = true;
  Icon? suffixConfirmPassIcon;
  bool inProcess = false;

  ///Sign In With Email And Pass
  void signInWithEmailAndPassword() async {
    try {
      inProcess = true;
      update();

      Get.snackbar(
        "Sign In Success",
        "Enjoy",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(30),
        snackPosition: SnackPosition.BOTTOM,
      );
      inProcess = false;
      update();
      Get.delete<AuthViewModel>();
    } catch (error) {
      inProcess = false;
      update();
      Get.snackbar(
        "Error Login Account",
        error.toString(),
        colorText: Colors.white,
        margin: const EdgeInsets.all(30),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// SIGN UP
  void signUpWithEmailAndPassword() async {}

  /// show password methods
  void showHidePassword() {
    hidePass = !hidePass;
    update();
  }

  IconData passwordIcon() {
    return hidePass ? Icons.remove_red_eye : Icons.visibility_off;
  }

  void clearController() {
    name.clear();
    email.clear();
    password.clear();
    confirmPassword.clear();
    update();
  }

  void isEqual() {
    if (password.text == confirmPassword.text) {
      suffixConfirmPassIcon = const Icon(
        Icons.done,
        color: pinkClr,
      );
    } else {
      suffixConfirmPassIcon = null;
    }
    // print(isNotEqual);
    update();
  }

  void offLineMode() {
    BoxStorage().putString(Constance.offLineMode, "1");
    Get.offAll(const HomeView());
  }

  /// forgetPass
// void resetPassword(String email) async {
//   try {
//     inProcess = true;
//     update();
//     await _firebaseAuth.sendPasswordResetEmail(email: email);
//     inProcess = false;
//     update();
//     Get.snackbar(
//       "mission success ",
//       '',
//       colorText: Colors.white,
//       backgroundColor: primaryColor,
//       margin: const EdgeInsets.all(30),
//       snackPosition: SnackPosition.BOTTOM,
//     );
//     Get.offAll(LoginView());
//   } catch (e) {
//     Get.snackbar(
//       "Error Send Email Account",
//       e.toString(),
//       colorText: Colors.white,
//       backgroundColor: errorColor,
//       margin: const EdgeInsets.all(30),
//       snackPosition: SnackPosition.BOTTOM,
//     );
//   }
// }

}
