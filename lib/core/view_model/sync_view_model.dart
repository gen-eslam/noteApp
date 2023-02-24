import 'package:get/get.dart';
import 'package:notes/core/helper/database_helper.dart';
import 'package:notes/core/helper/online_database_helper.dart';

import '../../model/note_model.dart';

class SyncViewModel extends GetxController{

  List<Note> _note = [];
  List<Note>  get note =>_note;
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  OnlineDataBase onlineDataBase = OnlineDataBase();
  @override
  void onInit() {
    getData();
    super.onInit();
  }

  Future<void> getData()async{
     _note = await databaseHelper.getNoteUnSyncList();
    print(_note);
    update();
  }
  void addToOnlineDatabase(Note note){
    onlineDataBase.addDataToOnlineDatabase(note);
  }
  void syncData(){
    _note.forEach((note) {
      onlineDataBase.addDataToOnlineDatabase(note);
      print("dane");
      databaseHelper.updateSyncedNote(note);
    });
    print("insert doneeeeeeeeeeee");
  }








}