import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';

abstract class MetaDataAbstract {}

class DeviceMetaData {
  String os = Platform.operatingSystem; // os type. ex) android, ios, mac...
  String? osVersion;
  String? osModel; // ex) Galaxy Note 20
  int? sdk; // only andriod

  DeviceMetaData() {
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

class AppMetaData {
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  AppMetaData() {
    setVersionInfo();
  }

  Future setVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    debugPrint(
        'appName: ${appName}, packageName: ${packageName}, version: ${version}, buildNumber: ${buildNumber}');
    return packageInfo;
  }
}
