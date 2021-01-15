import 'package:demo/provider/view_state_model.dart';
import 'package:demo/services/apiresponse.dart';
import 'package:demo/view_model/user_model.dart';

class LoginModel extends ViewStateModel {
  UserModel userModel = UserModel();

  //登录操作
  Future<bool> login(username, password) async {
    setBusy();
    try {
      var user = await ApiResponse.login(username, password);
      userModel.saveUser(user);
      setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> logout() async {
    if (!userModel.hasUser) {
      //防抖
      return false;
    }
    setBusy();
    try {
      // await ApiResponse.logout();
      // userModel.clearUser();
      // setIdle();
      return true;
    } catch (e, s) {
      setError(e, s);
      return false;
    }
  }

  Future<bool> test() async {
    setBusy();
    Future.delayed(Duration(seconds: 3), (){
    print('延时1s执行');
    setIdle();
});
  }
}
