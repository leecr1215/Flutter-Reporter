import 'package:flutter_reporter/models/metadata_app_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppMetaDataViewModel {
  AppMetaData appMetaData = AppMetaData();

  AppMetaDataViewModel() {
    setVersionInfo();
  }

  Future setVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appMetaData.appName = packageInfo.appName;
    appMetaData.packageName = packageInfo.packageName;
    appMetaData.version = packageInfo.version;
    appMetaData.buildNumber = packageInfo.buildNumber;
    //notifyListeners();
  }

  String get appName {
    return appMetaData.appName;
  }

  String get packageName {
    return appMetaData.packageName;
  }

  String get version {
    return appMetaData.version;
  }

  String get buildNumber {
    return appMetaData.buildNumber;
  }
}
