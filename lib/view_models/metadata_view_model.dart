import 'package:flutter/cupertino.dart';
import 'package:flutter_reporter/view_models/metadata_flutter_mode_view_model.dart';

class MetaDataViewModel with ChangeNotifier {
  late FlutterModeViewModel flutterModeViewModel;

  MetaDataViewModel() {
    flutterModeViewModel = FlutterModeViewModel();

    notifyListeners();
  }
}
