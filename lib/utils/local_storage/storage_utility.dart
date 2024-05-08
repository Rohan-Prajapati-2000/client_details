import 'package:get_storage/get_storage.dart';

class SLocalStorage{
  static final SLocalStorage _instance = SLocalStorage._internal();

  factory SLocalStorage(){
    return _instance;
  }

  SLocalStorage._internal();


  final _storage = GetStorage();

  // Generic Method to save the data
  Future<void> saveData<T>(String key, value) async{
    await _storage.write(key, value);
  }

  // Generic Method to read the data
  T? readData<T>(String key, value) {
    return _storage.read<T>(key);
  }

  // Generic Method to remove the data
  Future<void> removeData<T>(String key, value) async{
    await _storage.remove(key);
  }

  // Clear all data in storage
  Future<void> clearAll() async{
    await _storage.erase();
  }
}