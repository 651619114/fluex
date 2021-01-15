import '../model/user.dart';
import 'package:dio/dio.dart';

class ApiResponse {
  static ApiResponse apiRespose;
  static Dio dio;
  String name;

  static void getDioInstance() {
    if (apiRespose == null || dio == null) {
      var api = ApiResponse._();
      api.init();
      apiRespose = api;
    }
  }

  void init() {
    dio = Dio();
    dio.options
      ..baseUrl = "https://ask.eol.cn/app2020/"
      ..connectTimeout = 1
      ..receiveTimeout = 1;
    dio.interceptors
      ..add(LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseBody: true,
          responseHeader: false));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async{
      
    }));
  }

  ApiResponse._();

  static Future login(String username, String password) async {
    Response response = await dio.get('member/login', queryParameters: {
      "format": "json",
      "phone": username,
      "password": password
    });
    Map<String, dynamic> data = Map();
    data['amdin'] = 'yes';
    data['username'] = 'aaa';
    data['token'] = '123123123';
    return User.fromJsonMap(data);
  }
}
