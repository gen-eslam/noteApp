import 'package:get/get.dart';
import 'package:notes/core/view_model/sync_view_model.dart';

import '../view_model/auth_view_model.dart';
import '../view_model/note_view_model.dart';

class Binding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel(),fenix: true);
    Get.lazyPut(() => NoteViewModel(),fenix: true);
    Get.lazyPut(() => SyncViewModel(),fenix: true);
  }

}