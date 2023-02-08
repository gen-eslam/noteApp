import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../view_model/auth_view_model.dart';
import '../view_model/note_view_model.dart';

class Binding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => NoteViewModel());
    // Get.lazyPut(() => BuildContext);
  }

}