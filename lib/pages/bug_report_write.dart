import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.Dart';
import 'package:flutter/services.Dart';
import 'package:path_provider/path_provider.dart';
import '../controller/screen_shot_list_loader.dart';
import 'Dart:io';
import 'Dart:async';
import 'Dart:typed_data';
import 'Dart:ui' as ui;
import '../controller/screen_shot_controller.dart';

class BugReportWrite extends StatefulWidget {
  BugReportWrite({Key? key}) : super(key: key);
  //final List<File> imagePaths;

  @override
  _BugReportWriteState createState() => _BugReportWriteState();
}

class _BugReportWriteState extends State<BugReportWrite>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  _BugReportWriteState({Key? key});

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [Tab(text: '스크린샷'), Tab(text: '리포트')];

  // @override
  // void initState() {
  //   _tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("리포트 페이지"), floatingActionButton: const BackFAB());
  }
}
