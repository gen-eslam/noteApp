import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notes/core/helper/database_helper.dart';
import 'package:notes/core/utils/get_storage.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

import '../../model/note_model.dart';
import '../themes/theme_services.dart';
import '../utils/constance.dart';

class NoteViewModel extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  List<Note> noteList = [];
  late final String drawerText;

  int contentWordCount = 0, contentCharCount = 0;

  @override
  void onInit() {
   drawerText = getTextFromBoxStorage();
    getAllNotes();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  bool isEmpty() {
    return noteList.isEmpty;
  }

  Future<void> addNoteToDatabase(BuildContext context) async {
    String title = titleController.text;
    String content = contentController.text;
    title.trim().isEmpty ? title = "unNamed" : title;
    Note note = Note(
      title: title,
      content: content,
      dateTimeCreated: DateFormat(Constance.dateFormat).format(DateTime.now()),
      dateTimeEdited: DateFormat(Constance.dateFormat).format(DateTime.now()),
    );
    await DatabaseHelper.instance.addNote(note);
    titleController.text = "";
    contentController.text = "";
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    FocusScope.of(context).unfocus();
    getAllNotes();
    Get.back();
  }

  Future<void> deleteNote(Note note) async {
    await DatabaseHelper.instance.deleteNote(note);
    getAllNotes();
  }

  Future<void> deleteAllNote() async {
    await DatabaseHelper.instance.deleteAllNotes();
    getAllNotes();
  }

  Future<void> updateNote(int id, String dateCreated) async {
    String title = titleController.text;
    String content = contentController.text;
    Note note = Note(
      noteId: id,
      title: title,
      content: content,
      dateTimeCreated: dateCreated,
      dateTimeEdited: DateFormat(Constance.dateFormat).format(DateTime.now()),
    );

    await DatabaseHelper.instance.updateNote(note);
    contentController.text = "";
    titleController.text = "";
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    getAllNotes();
    Get.back();
  }

  Future<void> getAllNotes() async {
    noteList = await DatabaseHelper.instance.getNoteList();
    print(noteList);
    update();
  }

  void shareNote(String title, String content) {
    Share.share("$title \n $content \n created my gen");
  }

  void clearAddNote() {
    titleController.text = "";
    contentController.text = "";
    Get.back();
  }

  String getTextFromBoxStorage() {
    if (BoxStorage().getString(Constance.userId) != null) {
      return "Welcome \n ${BoxStorage().getString(Constance.userName)}";
    }
    return "Welcome";
  }

  void changeTheme() {
    ThemeService().switchTheme();
    update();
  }
}
