import 'package:flutter_reporter/models/metadata_flutter_mode_model.dart';
import 'package:flutter/foundation.dart';

class FlutterModeViewModel {
  FlutterMode flutterMode = FlutterMode();

  FlutterModeViewModel() {
    flutterMode.mode = setMode();
  }

  String setMode() {
    if (kDebugMode) {
      return "debug";
    } else if (kReleaseMode) {
      return "release";
    } else {
      return "profile";
    }
  }

  String get mode {
    return flutterMode.mode;
  }
}
