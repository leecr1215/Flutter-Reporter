import 'package:flutter/material.dart';
import 'dart:io';
import '../controller/bug_report_list_loader.dart';

class BugReportList extends StatefulWidget {
  BugReportList({
    Key? key,
    required this.bugReport,
  }) : super(key: key);

  BugReport bugReport;

  @override
  _BugReportListState createState() => _BugReportListState();
}

class _BugReportListState extends State<BugReportList> {
  //Map<String, dynamic> map = {};
  late BugReport bugReport;

  @override
  void initState() {
    //bugReport = widget.bugReport;
    // map = bugReport.getReportList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BugReport bugReport = widget.bugReport;
    print(bugReport.getReportList());
    List keys = bugReport.getKeys();
    return GridView.builder(
      itemCount: 5,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "${bugReport.getTitle(keys[index])}",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Image.file(File('${bugReport.getImage(keys[index])}'),
                    fit: BoxFit.contain),
              ),
              Text("${bugReport.getCurrentTime(keys[index])}",
                  style: TextStyle(fontSize: 12))
            ],
          ),
        );
      },
    );
  }
}
