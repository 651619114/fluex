import 'package:demo/libraries/localstorage_init.dart';
import 'package:demo/libraries/shared_preferences_init.dart';
import 'package:demo/model/user.dart';
import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier {
  static const String ownUser = "ownUser";
  static const String _token = "TOKEN";
  User _user;
  User get user => _user;
  //判断登录状态
  bool get hasUser => user != null;

  String get token => SpUtil.getString(_token);

  UserModel() {
    var userMap = LocalStorageInit.local.getItem(ownUser);
    _user = userMap != null ? User.fromJsonMap(userMap) : null;
  }

  saveUser(User user) {
    _user = user;
    LocalStorageInit.local.setItem(ownUser, user);
    SpUtil.putString(_token, user.toJson()['token']);
    notifyListeners();
  }

  clearUser() {
    SpUtil.remove(_token);
    LocalStorageInit.local.deleteItem(ownUser);
    notifyListeners();
  }
}
