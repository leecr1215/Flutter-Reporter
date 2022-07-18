import 'package:flutter/material.dart';
import 'package:flutter_reporter/view_models/report_list_view_model.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class BugReportListView extends StatelessWidget {
  BugReportListView({
    Key? key,
  }) : super(key: key);

  late BugReportListViewModel viewModel;
  //final BugReport bugReport = BugReport();

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<BugReportListViewModel>(
        context); // Provider로 viewModel 가져오기
    List keys = viewModel.keys;
    final itemCount = keys.length;

    return keys.isEmpty
        ? const Text("저장된 버그 리포트가 없습니다.")
        : GridView.builder(
            itemCount: itemCount,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 3,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              final key = keys[index];
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    viewModel.getValue(key, 'title'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Image.file(
                      File(
                        viewModel.getValue(key, 'image'),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Text(viewModel.getValue(key, 'currentTime'),
                      style: const TextStyle(fontSize: 12))
                ],
              );
            },
          );
  }
}
