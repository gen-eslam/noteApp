import 'package:get/get.dart';
import 'package:notes/core/utils/constance.dart';
import 'package:notes/core/utils/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/note_model.dart';

class OnlineDataBase {
  OnlineDataBase._init();

  static final OnlineDataBase _onlineDataBase = OnlineDataBase._init();

  factory OnlineDataBase() {
    return _onlineDataBase;
  }

  final supabase = Supabase.instance.client;

  static Future<void> init() async {
    await Supabase.initialize(
        url: Constance.onlineDatabaseUrl, anonKey: Constance.apiKey);
  }

  Future<AuthResponse> signInWithEmail(
      {required String email, required String password}) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signupWithEmail(
      {required String email, required String password, String? name}) async {
    return await supabase.auth.signUp(
      email: email,
      password: password,
      data: {"name": name},
    );
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
  }

  Future<void> getAllOnlineData() async {
    List<dynamic> noteMap = await supabase
        .from(Constance.onlineDatabaseName)
        .select(
            "${Constance.noteId},${Constance.noteTitle},${Constance.noteContent},${Constance.noteDateTimeCreated},${Constance.noteDateTimeEdited}")
        .eq(Constance.userId, BoxStorage().getString(Constance.userId));
    List<Note> note =
        List.generate(noteMap.length, (index) => Note.fromJson(noteMap[index]));
    print("online data");
    print(noteMap);
  }

  Future<void> addDataToOnlineDatabase(Note note) async {
    await supabase
        .from(Constance.onlineDatabaseName)
        .insert(note.toOnlineData());
  }

  Future<void> updateDataOnOnlineDatabase(Note note) async {
    await supabase
        .from(Constance.onlineDatabaseName)
        .update(note.toOnlineData())
        .match({
      Constance.userId: BoxStorage().getString(Constance.userId),
      Constance.noteId: note.noteId
    });
  }

  Future<void> deleteDataOnOnlineDatabase(Note note) async {
    await supabase.from(Constance.onlineDatabaseName).delete().match({
      Constance.userId: BoxStorage().getString(Constance.userId),
      Constance.noteId: note.noteId
    });
  }
}
