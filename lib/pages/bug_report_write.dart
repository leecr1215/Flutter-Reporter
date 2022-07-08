import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';

class BugReportWrite extends StatefulWidget {
  BugReportWrite({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("리포트 페이지"), floatingActionButton: const BackFAB());
  }
}
