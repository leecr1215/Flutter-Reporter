import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

abstract class BugReportListLoader {
  Future<Map<String, dynamic>> getReportList();
}

class BugReport implements BugReportListLoader {
  List keys = [];
  Map<String, dynamic> map = <String, dynamic>{};

  @override
  Future<Map<String, dynamic>> getReportList() async {
    // TODO: 저장된 버그 리포트 불러오기
    // json 파일이 없는 경우에는 어떻게 할지 생각해야함
    await Future.delayed(const Duration(milliseconds: 10), () async {
      final directory = (await getApplicationDocumentsDirectory()).path;
      File jsonFile = File('$directory/bug_report.json');
      String jsonString = await jsonFile.readAsString();

      map = await jsonDecode(jsonString);
      getKeys();
    });
    return map;
  }

  void getKeys() {
    map.forEach((key, value) {
      keys.add(key);
    });
  }

  Map<String, dynamic> getValue(key) {
    print('$key의 값은? : ${map[key][0]}');
    return map[key][0];
  }

  String getTitle(key) {
    return map[key][0]['title'];
  }

  String getImage(key) {
    return map[key][0]['image'];
  }

  String getCurrentTime(key) {
    return map[key][0]['currentTime'];
  }
}
