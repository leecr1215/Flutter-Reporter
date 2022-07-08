import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.Dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'Dart:async';
import 'Dart:typed_data';
import 'package:intl/intl.dart';
import 'Dart:ui' as ui;
import '../controller/screen_shot_controller.dart';
import '../pages/screen_shot_list.dart';

abstract class BugReportController {
  void saveItems();
}

class BugReportItem {
  String title;
  String author;
  String content;
  String currentTime;
  String image;

  BugReportItem(
      {required this.title,
      required this.author,
      required this.content,
      required this.currentTime,
      required this.image});

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> map = <String, dynamic>{};

    map['title'] = title;
    map['author'] = author;
    map['content'] = content;
    map['currentTime'] = currentTime;
    map['image'] = image;

    return map;
  }
}

class BugReportList {
  List<BugReportItem> items = [];

  List toJSONEnable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}
