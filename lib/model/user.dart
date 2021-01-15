class User {
  bool admin;
  String token;
  String username;
  int id;

  User.fromJsonMap(Map<String, dynamic> map)
      : admin = map["admin"],
        token = map["token"],
        id = map["id"],
        username = map["username"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = admin;
    data['token'] = token;
    data['username'] = username;
    data['id'] = id;
    return data;
  }
}
