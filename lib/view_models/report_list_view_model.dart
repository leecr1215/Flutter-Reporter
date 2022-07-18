import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class BugReportListViewModel with ChangeNotifier {
  List keys = [];
  Map<String, dynamic> map = <String, dynamic>{};

  BugReportListViewModel() {
    setReportList();
  }

  /* 저장된 버그 리포트 불러오기 */
  Future<void> setReportList() async {
    await Future.delayed(const Duration(milliseconds: 10), () async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File jsonFile = File('$directory/bug_report.json');
      String jsonString = await jsonFile.readAsString();
      map = await jsonDecode(jsonString);
      setKeys();
      notifyListeners();
    });
  }

  /* keys에 key 추가 */
  void setKeys() {
    map.forEach((key, value) {
      keys.add(key);
    });
  }

  String getValue(key, String category) {
    // 존재 category : title, image, author, content, currentTime
    return map[key][0][category];
  }
}
