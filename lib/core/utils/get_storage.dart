import 'package:get_storage/get_storage.dart';

class BoxStorage{
  final _box = GetStorage();

  void putString(String key ,String value){
    _box.write(key, value);
  }
  String? getString(String key){
    return _box.read(key);
  }




}