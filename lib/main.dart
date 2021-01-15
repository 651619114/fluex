import 'package:demo/libraries/localstorage_init.dart';
import 'package:demo/model/user_sql_model.dart';
import 'package:demo/provider/provider_widget.dart';
import 'package:demo/provider/view_state_widget.dart';
import 'package:demo/services/apiresponse.dart';
import 'package:demo/view_model/login_model.dart';
import 'package:flutter/material.dart';
import './libraries/shared_preferences_init.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'model/user.dart';
import './libraries/device_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //SharePreferences初始化
  await SpUtil.getSharePreferencesInstance();

  //LocalStorage初始化
  await LocalStorageInit.getLocalStorageInstance();

  //Dio初始化
  await ApiResponse.getDioInstance();

  //deviceinfo初始化
  await DeviceInfo.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ProviderWidget(
        onModelReady: (model) => model.test(),
        model: LoginModel(),
        builder: (context, model, child) {
          return model.isBusy?ViewStateUnAuthWidget():Container();
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            data = SpUtil.getInt('1');
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
    // );
  }
}

void insert() async {
  UserSqlModel userSql = new UserSqlModel();
  userSql.insert(User.fromJsonMap({"id": 1, "username": "123"}));
}

Future getdata() async {
  UserSqlModel userSql = new UserSqlModel();
  var a = await userSql.getInfo(1);
  print(a.toJson());
}
