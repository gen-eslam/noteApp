import 'package:get/get.dart';
import 'package:notes/core/helper/database_helper.dart';

import '../../model/note_model.dart';

class SyncViewModel extends GetxController{

  List<Note> _note = [];
  List<Note>  get note =>_note;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData()async{
    _note = await databaseHelper.getNoteListOnlineData();
    print(_note);
    update();
  }








}