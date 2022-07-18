import 'package:flutter/material.dart';
import 'package:flutter_reporter/view_models/report_list_view_model.dart';
import 'package:flutter_reporter/views/report_list_view.dart';
import 'package:provider/provider.dart';

class BugReportListPage extends StatelessWidget {
  const BugReportListPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BugReportListViewModel>(
        create: (_) => BugReportListViewModel(), child: BugReportListView());
  }
}
