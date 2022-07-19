import 'package:flutter/widgets.dart';

class AppMetaData with ChangeNotifier {
  String? appName;
  String? packageName;
  String? version;
  String? buildNumber;

  AppMetaData({this.appName, this.buildNumber, this.packageName, this.version});

  String? get getAppName => appName;
  String? get getPackageName => packageName;
  String? get getVersion => version;
  String? get getBuildNumber => buildNumber;
}
