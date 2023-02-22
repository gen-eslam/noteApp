import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/note_model.dart';
import '../../model/synced_data_model.dart';
import '../utils/constance.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _dbName = "notes.db";
  static const _dbVersion = 1;
  static const _tableName = "notes";
  static const _syncDatabase = "syncData";

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        ${Constance.noteId} INTEGER PRIMARY KEY autoincrement,
        ${Constance.noteTitle} TEXT NOT NULL,
        ${Constance.noteContent} TEXT NOT NULL,
        ${Constance.noteDateTimeCreated} TEXT NOT NULL,
        ${Constance.noteDateTimeEdited} TEXT NOT NULL,
        ${Constance.syncDataStatus} TEXT NOT NULL
        )
      ''');
    await db.execute('''
          CREATE TABLE $_syncDatabase(
       ${Constance.noteId} INTEGER,
        ${Constance.dataStatus} TEXT NOT NULL
      )
        ''');
    print("created data done");
  }
  Future<List<Note>> getNoteList() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(_tableName);
    print(maps);

    return List.generate(
      maps.length,
          (index) {
        return Note(
          noteId: maps[index][Constance.noteId],
          title: maps[index][Constance.noteTitle],
          content: maps[index][Constance.noteContent],
          dateTimeEdited: maps[index][Constance.noteDateTimeEdited],
          dateTimeCreated: maps[index][Constance.noteDateTimeCreated],
          syncDataStatus: maps[index][Constance.syncDataStatus]
        );
      },
    );
  }
  Future<List<Note>> getNoteUnSyncList() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(_tableName,where:"${Constance.syncDataStatus} = ?", whereArgs: [SyncDataStatus.unSynced.name]);

    return List.generate(
      maps.length,
          (index) {
        return Note(
          noteId: maps[index][Constance.noteId],
          title: maps[index][Constance.noteTitle],
          content: maps[index][Constance.noteContent],
          dateTimeEdited: maps[index][Constance.noteDateTimeEdited],
          dateTimeCreated: maps[index][Constance.noteDateTimeCreated],
          syncDataStatus: maps[index][Constance.syncDataStatus],

        );
      },
    );
  }



  Future<void> addNote(Note note) async {
    Database? db = await instance.database;
     await db!.insert(_tableName, note.toJson());
  }
  Future<void> addModifiedData({required int id, required String status}) async {
    Database? db = await instance.database;
    SyncedData syncedData = SyncedData(id: id,dataStatus: status);
     await db!.insert(_syncDatabase, syncedData.toJson());
  }

  Future<bool> findRecord(int noteId)async{
    Database? db = await instance.database;
    List<Map<String, Object?>> result = await db!.rawQuery("SELECT * FROM $_syncDatabase WHERE ${Constance.noteId} = $noteId");
    return result.isNotEmpty;
  }

  Future<void> deleteNote(Note note) async {
    Database? db = await instance.database;
     await db!.delete(
      _tableName,
      where: "${Constance.noteId} = ?",
      whereArgs: [note.noteId],
    );
  }



  Future<int> deleteAllNotes() async {
    Database? db = await instance.database;
    return await db!.delete(_tableName);
  }

  Future<int> updateNote(Note note) async {
    Database? db = await instance.database;
    if(note.syncDataStatus == SyncDataStatus.synced.name){

    }
    return await db!.update(
      _tableName,
      note.toJson(),
      where: "${Constance.noteId} = ?",
      whereArgs: [note.noteId],
    );
  }
  Future<int> updateSyncedNote(Note note) async {
    Database? db = await instance.database;
    return await db!.update(
      _tableName,
      note.toJson(syncDataStatus: SyncDataStatus.synced),
      where: "${Constance.noteId} = ?",
      whereArgs: [note.noteId],
    );
  }












}
