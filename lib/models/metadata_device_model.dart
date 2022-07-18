import 'dart:io';

class DeviceMetaData {
  String os = Platform.operatingSystem; // os type. ex) android, ios, mac...
  String? osVersion;
  String? osModel; // ex) Galaxy Note 20
  int? sdk; // only andriod have
}
