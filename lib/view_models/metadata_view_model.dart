import 'package:flutter/cupertino.dart';
//import 'package:flutter_reporter/view_models/metadata_app_view_model.dart';
//import 'package:flutter_reporter/view_models/metadata_device_view_model.dart';
import 'package:flutter_reporter/view_models/metadata_flutter_mode_view_model.dart';

class MetaDataViewModel with ChangeNotifier {
  //late AppMetaDataViewModel appMeataDataViewModel;
  //late DeviceMetaDataViewModel deviceMetaDataViewModel;
  late FlutterModeViewModel flutterModeViewModel;

  MetaDataViewModel() {
    //appMeataDataViewModel = AppMetaDataViewModel();

    //deviceMetaDataViewModel = DeviceMetaDataViewModel();

    flutterModeViewModel = FlutterModeViewModel();

    notifyListeners();
  }
}
