import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:notes/core/helper/online_database_helper.dart';
import 'package:notes/core/utils/get_storage.dart';
import 'package:notes/view/auth/login_view.dart';
import 'package:notes/view/home_view.dart';

import '../helper/database_helper.dart';
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
  final OnlineDataBase _onlineDataBase = OnlineDataBase();
  final BoxStorage _boxStorage = BoxStorage();

  void signupWithEmailAndPassword() async {
    inProcess = true;
    update();
    await _onlineDataBase
        .signupWithEmail(
            email: email.text, password: password.text, name: name.text)
        .then((value) {
      print("success");
      putDataFromBoxStorage(name:name.text,email:email.text,id: value.user!.id);
      inProcess = false;
      update();
      clearController();
      Get.offAll(const HomeView());
    }).onError((error, stackTrace) {
      print(error);
      inProcess = false;
      update();
    });
  }

  void logInWithEmailAndPassword() async {
    inProcess = true;
    update();
    await _onlineDataBase
        .signInWithEmail(email: email.text, password: password.text)
        .then((value) {
      print("success");
      putDataFromBoxStorage(name:name.text,email:email.text,id: value.user!.id);
      inProcess = false;
      update();
      clearController();
      Get.offAll(const HomeView());
    }).onError((error, stackTrace) {
      Get.snackbar("Invalid Email or Password", "Check Your Email and Password",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          colorText: offWhite,
          backgroundColor: pinkClr);
      inProcess = false;
      update();
    });
  }

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
  void putDataFromBoxStorage({required String name,required String id ,required String email }){
    _boxStorage.putString(Constance.userId, id );
    _boxStorage.putString(Constance.userEmail,email );
    _boxStorage.putString(Constance.userName,name );

  }
  Future<void> signOut()async{

    await _onlineDataBase.signOut().then((value)async{
      await DatabaseHelper.instance.deleteAllNotes();
      _boxStorage.clear();
      Get.offAll(LoginView());
    }).onError((error, stackTrace){
      Get.snackbar("Check Internet Connection", "open Wifi or mobileData",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(20),
          colorText: offWhite,
          backgroundColor: pinkClr);
    });



  }

}
