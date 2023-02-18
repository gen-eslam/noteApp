import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/note_model.dart';
import '../utils/constance.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static const _dbName = "notes.db";
  static const _syncDatabase = "syncData.db";
  static const _dbVersion = 1;
  static const _tableName = "notes";

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

  Future<void> _onCreate(Database db, int version) {
    return db.execute('''
      CREATE TABLE $_tableName(
        ${Constance.noteId} INTEGER PRIMARY KEY,
        ${Constance.noteTitle} TEXT NOT NULL,
        ${Constance.noteContent} TEXT NOT NULL,
        ${Constance.noteDateTimeCreated} TEXT NOT NULL,
        ${Constance.noteDateTimeEdited} TEXT NOT NULL
      )
      CREATE TABLE $_syncDatabase(
       ${Constance.noteId} INTEGER PRIMARY KEY,
        ${Constance.noteTitle} TEXT NOT NULL,
        ${Constance.noteContent} TEXT NOT NULL,
        ${Constance.noteDateTimeCreated} TEXT NOT NULL,
        ${Constance.noteDateTimeEdited} TEXT NOT NULL,
        ${Constance.dataStatus} TEXT NOT NULL
      )
      ''');
  }

  // Add Note
  Future<int> addNote(Note note) async {
    Database? db = await instance.database;
    await addOnlineData(note,Constance.dataAdd);
    return await db!.insert(_tableName, note.toJson());
  }

  // Delete Note
  Future<int> deleteNote(Note note) async {
    Database? db = await instance.database;
    await deleteOnlineDatabaseNotes(note);

    return await db!.delete(
      _tableName,
      where: "${Constance.noteId} = ?",
      whereArgs: [note.noteId],
    );
  }

  // Delete All Notes
  Future<int> deleteAllNotes() async {
    Database? db = await instance.database;
    List<Note> notes = await getNoteList();
    for(Note item in notes){
      deleteOnlineDatabaseNotes(item);
    }
    return await db!.delete(_tableName);
  }

  // Update Note
  Future<int> updateNote(Note note) async {
    Database? db = await instance.database;
    await updateOnlineDatabaseNotes(note);
    return await db!.update(
      _tableName,
      note.toJson(),
      where: "${Constance.noteId} = ?",
      whereArgs: [note.noteId],
    );
  }

  Future<List<Note>> getNoteList() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(_tableName);

    return List.generate(
      maps.length,
      (index) {
        return Note(
          noteId: maps[index][Constance.noteId],
          title: maps[index][Constance.noteTitle],
          content: maps[index][Constance.noteContent],
          dateTimeEdited: maps[index][Constance.noteDateTimeEdited],
          dateTimeCreated: maps[index][Constance.noteDateTimeCreated],
        );
      },
    );
  }
  /// online data
  Future<List<Note>> getNoteListOnlineData() async {
    Database? db = await instance.database;
    final List<Map<String, dynamic>> maps = await db!.query(_syncDatabase);

    return List.generate(
      maps.length,
      (index) {
        return Note(
          noteId: maps[index][Constance.noteId],
          title: maps[index][Constance.noteTitle],
          content: maps[index][Constance.noteContent],
          dateTimeEdited: maps[index][Constance.noteDateTimeEdited],
          dateTimeCreated: maps[index][Constance.noteDateTimeCreated],
          status: maps[index][Constance.dataStatus],
        );
      },
    );
  }
  Future<int> addOnlineData(Note note,String status) async {
    Database? db = await instance.database;
    return await db!.insert(_syncDatabase,{
    Constance.noteId: note.noteId,
    Constance.noteTitle: note.title,
    Constance.noteContent: note.content,
    Constance.noteDateTimeCreated: note.dateTimeCreated,
    Constance.noteDateTimeEdited: note.dateTimeEdited,
    Constance.dataStatus: status,
    });
  }
  Future<int> deleteAllOnlineDatabaseNotes() async {
    Database? db = await instance.database;
    return await db!.delete(_syncDatabase);
  }
  Future<bool> findInOnlineDatabase(int noteId)async{
    Database? db = await instance.database;
    List<Map<String, Object?>> _find = await db!.query(
      _syncDatabase,
      columns: [Constance.noteId],
      where: "${Constance.noteId} = ?",
      whereArgs: [noteId],
    );
    return _find.isEmpty;

  }
  Future<void> updateOnlineDatabaseNotes(Note note) async {
    Database? db = await instance.database;
    if(await findInOnlineDatabase(note.noteId!)){
     await addOnlineData(note, Constance.dataUpdate);
    }else{
      await db!.update(
        _syncDatabase,
        {
          Constance.noteId: note.noteId,
          Constance.noteTitle: note.title,
          Constance.noteContent: note.content,
          Constance.noteDateTimeCreated: note.dateTimeCreated,
          Constance.noteDateTimeEdited: note.dateTimeEdited,
          Constance.dataStatus: Constance.dataUpdate,
        },
        where: "${Constance.noteId} = ?",
        whereArgs: [note.noteId],
      );
    }
  }
  Future<void> deleteOnlineDatabaseNotes(Note note) async {
    Database? db = await instance.database;
    if(await findInOnlineDatabase(note.noteId!)){
     await addOnlineData(note, Constance.dataDelete);
    }else{
      await db!.update(
        _syncDatabase,
        {
          Constance.noteId: note.noteId,
          Constance.noteTitle: note.title,
          Constance.noteContent: note.content,
          Constance.noteDateTimeCreated: note.dateTimeCreated,
          Constance.noteDateTimeEdited: note.dateTimeEdited,
          Constance.dataStatus: Constance.dataDelete,
        },
        where: "${Constance.noteId} = ?",
        whereArgs: [note.noteId],
      );
    }
  }


}
