
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthViewModel extends GetxController {
  late String email, password, name;
  bool hidePass = true;
  bool isValidate = true;
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
  void signUpWithEmailAndPassword() async {

  }

  /// show password methods
  void showHidePassword() {
    hidePass = !hidePass;
    update();
  }

  IconData passwordIcon() {
    return hidePass ? Icons.remove_red_eye : Icons.visibility_off;
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
