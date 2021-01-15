import 'package:localstorage/localstorage.dart';

class LocalStorageInit {
  static LocalStorageInit localStorage;
  static LocalStorage local;

  LocalStorageInit._();
  static Future<LocalStorageInit> getLocalStorageInstance() async {
    var _localStorage = LocalStorageInit._();
    await _localStorage.init();
    localStorage = _localStorage;
    return localStorage;
  }

  Future init() async{
    local = LocalStorage('storage');
    await local.ready;
  }
}