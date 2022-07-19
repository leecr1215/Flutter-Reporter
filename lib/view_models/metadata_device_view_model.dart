import 'package:flutter/cupertino.dart';
import 'package:flutter_reporter/models/metadata_device_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

class DeviceMetaDataViewModel with ChangeNotifier {
  DeviceMetaData deviceMetaData = DeviceMetaData();
  bool _isLoading = false;
  DeviceMetaDataViewModel() {
    setVersionInfo();
  }

  Future setVersionInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (deviceMetaData.os == 'android') {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMetaData.osVersion = androidInfo.version.release;
      deviceMetaData.sdk = androidInfo.version.sdkInt;

      deviceMetaData.osModel = androidInfo.model;
    } else if (deviceMetaData.os == 'iOS') {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMetaData.osVersion = iosInfo.systemVersion;
      deviceMetaData.osModel = iosInfo.utsname.machine;
    }
    _isLoading = true;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  String get os {
    return deviceMetaData.os;
  }

  String get osVersion {
    return deviceMetaData.osVersion as String;
  }

  String get osModel {
    return deviceMetaData.osModel as String;
  }

  int get sdk {
    return deviceMetaData.sdk as int;
  }
}
