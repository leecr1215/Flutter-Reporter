import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';

abstract class MetaDataAbstract {}

class MetaDataInfo {
  String os = Platform.operatingSystem; // os type. ex) android, ios, mac...
  String? osVersion;
  String? osModel; // ex) Galaxy Note 20
  int? sdk; // only andriod

  MetaDataInfo() {
    setVersionInfo();
  }

  void setVersionInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (os == 'android') {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      osVersion = androidInfo.version.release;
      sdk = androidInfo.version.sdkInt;
      // var manufacturer = androidInfo.manufacturer;
      osModel = androidInfo.model;
    } else if (os == 'iOS') {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      osVersion = iosInfo.systemVersion;
      osModel = iosInfo.utsname.machine;
      // return iosInfo.utsname.version.toString();
    }
  }
}
