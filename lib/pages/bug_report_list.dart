import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import '../controller/screen_shot_list_loader.dart';
import 'dart:io';
import '../controller/screen_shot_controller.dart';
import 'bug_report_write.dart';
import 'package:localstorage/localstorage.dart';
import '../controller/bug_report_list_loader.dart';
import '../controller/bug_report_list_loader.dart';

class BugReportList extends StatelessWidget {
  BugReportList({
    Key? key,
    required this.imagePaths,
  }) : super(key: key);

  final List<File> imagePaths;

  BugReport bugReport = BugReport();

  @override
  Widget build(BuildContext context) {
    bugReport.getReportList();
    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Image.file(imagePaths[index]),
          ],
        );
      },
    );
  }
}
