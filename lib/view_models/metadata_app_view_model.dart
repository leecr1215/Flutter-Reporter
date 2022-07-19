import 'package:flutter/cupertino.dart';
import 'package:flutter_reporter/models/metadata_app_model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppMetaDataViewModel with ChangeNotifier {
  AppMetaData appMetaData = AppMetaData();
  bool _isLoading = false;

  AppMetaDataViewModel() {
    setVersionInfo();
  }

  Future setVersionInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appMetaData.appName = packageInfo.appName;
    appMetaData.packageName = packageInfo.packageName;
    appMetaData.version = packageInfo.version;
    appMetaData.buildNumber = packageInfo.buildNumber;
    _isLoading = true;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
