import 'package:flutter/material.dart';
import 'dart:io';
import '../controller/bug_report_list_loader.dart';

class BugReportList extends StatefulWidget {
  BugReportList({
    Key? key,
  }) : super(key: key);

  final BugReport bugReport = BugReport();

  @override
  State<BugReportList> createState() => _BugReportListState();
}

class _BugReportListState extends State<BugReportList> {
  late BugReport bugReport;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BugReport bugReport = widget.bugReport;
    return FutureBuilder<Map<String, dynamic>>(
      future: bugReport.getReportList(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List keys = bugReport.keys;

          // 저장된 것이 없는 경우
          if (keys.isEmpty) {
            return const Text("저장된 버그 리포트가 없습니다.");
          } else {
            return GridView.builder(
              itemCount: keys.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      bugReport.getTitle(keys[index]),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Flexible(
                      child: Image.file(
                        File(bugReport.getImage(keys[index])),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(bugReport.getCurrentTime(keys[index]),
                        style: const TextStyle(fontSize: 12))
                  ],
                );
              },
            );
          }
        } else {
          return const Text("값을 불러올 수 없습니다.");
        }
      },
    );
  }
}
