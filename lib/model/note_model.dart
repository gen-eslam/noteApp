import '../core/utils/constance.dart';

class Note {
  int? noteId;
  String? title, content, dateTimeEdited, dateTimeCreated;

  Note({
    this.noteId,
    this.content,
    this.title,
    this.dateTimeCreated,
    this.dateTimeEdited,
  });

  factory Note.fromJson(Map<dynamic, dynamic> json) => Note(
        title: json[Constance.noteTitle],
        content: json[Constance.noteContent],
        noteId: json[Constance.noteId],
        dateTimeCreated: json[Constance.noteDateTimeCreated],
        dateTimeEdited: json[Constance.noteDateTimeEdited],
      );

  toJson() {
    return {
      Constance.noteId:noteId,
      Constance.noteTitle: title,
      Constance.noteContent: content,
      Constance.noteDateTimeCreated: dateTimeCreated,
      Constance.noteDateTimeEdited: dateTimeEdited,
    };
  }
}
