import 'package:notes/core/utils/constance.dart';

class SyncedData{
  int id;
  String dataStatus;

  SyncedData({
    required this.id,
    required this.dataStatus
});
  factory SyncedData.fromJson(Map<dynamic, dynamic> json) => SyncedData(
    id:json[Constance.noteId],
    dataStatus:json[Constance.dataStatus],

  );
  toJson(){
    return{
      Constance.noteId:id,
      Constance.dataStatus: dataStatus
    };
  }


}

