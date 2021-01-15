import 'dart:io';
import 'package:device_info/device_info.dart';
import './shared_preferences_init.dart';

class DeviceInfo {
  static DeviceInfoPlugin _device_info;
  static String device_name;
  static init() async {
    if (SpUtil.getString('deviceName') != "") {
      device_name = SpUtil.getString('deviceName');
    } else {
      _device_info = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await _device_info.androidInfo;
        SpUtil.putString('deviceName', androidInfo.model);
        device_name = androidInfo.model;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await _device_info.iosInfo;
        SpUtil.putString('deviceName', iosInfo.utsname.machine);
        device_name = iosInfo.utsname.machine;
      }
    }
  }
}
