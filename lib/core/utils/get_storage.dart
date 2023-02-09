import 'package:get_storage/get_storage.dart';

class BoxStorage{
  BoxStorage._init();
  static final BoxStorage _boxStorage = BoxStorage._init();
  factory BoxStorage(){
    return _boxStorage;
  }
  final _box = GetStorage();


  void putString(String key ,String value){
    _box.write(key, value);
  }

  String? getString(String key){
    return _box.read(key);
  }




}