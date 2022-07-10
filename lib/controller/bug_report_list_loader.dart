import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.Dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

abstract class BugReportListLoader {
  void getReportList();
}

class BugReport implements BugReportListLoader {
  @override
  void getReportList() {
    // TODO: 저장된 버그 리포트 불러오기
  }
}
