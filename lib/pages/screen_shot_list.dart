import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import '../controller/screen_shot_list_loader.dart';
import 'dart:io';
import '../controller/screen_shot_controller.dart';
import 'bug_report_write.dart';
import 'package:localstorage/localstorage.dart';
import '../controller/bug_report_list_loader.dart';
import 'bug_report_list.dart';

class ScreenShotListPage extends StatefulWidget {
  ScreenShotImage screenShotImage;
  ScreenShotListPage({Key? key, required this.screenShotImage})
      : super(key: key);

  @override
  _ScreenShotListPageState createState() => _ScreenShotListPageState();
}

class _ScreenShotListPageState extends State<ScreenShotListPage>
    with SingleTickerProviderStateMixin
    implements ScreenShotListLoader {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [Tab(text: '스크린샷'), Tab(text: '리포트')];
  LocalStorage storage = LocalStorage('bug_report.json');

  Map<String, dynamic> map = {};

  late BugReport bugReport;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    waitStorageReady();
    bugReport = BugReport();

    super.initState();
  }

  void waitStorageReady() async {
    await storage.ready
        .then((value) => storage = LocalStorage('bug_report.json'));
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BugReport bugReport = BugReport();
    final List<File> imagePaths = widget.screenShotImage.getImagePaths();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    print(bugReport.keys);
    return Scaffold(
        body: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TabBar(
                unselectedLabelColor: Colors.black,
                labelColor: Colors.white,
                tabs: _tabs,
                controller: _tabController,
                indicatorPadding: EdgeInsets.all(5.0),
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: _selectedColor),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    showScreenShotList(),
                    BugReportList(bugReport: bugReport)
                  ],
                  controller: _tabController,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Align(
          alignment: Alignment.bottomLeft,
          child: const BackFAB(),
        ));
  }

  @override
  GridView showScreenShotList() {
    // TODO: 스크린샷 리스트 조회 child
    final List<File> imagePaths = widget.screenShotImage.getImagePaths();
    return GridView.builder(
      itemCount: imagePaths.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onLongPress: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BugReportWrite(
                        screenShotImage: widget.screenShotImage, index: index)),
              );
            },
            child: Image.file(imagePaths[index]));
      },
    );
  }

  //@override
  GridView showBugReportList() {
    // TODO: 버그 리포트 리스트 조회 child
    final List<File> imagePaths = widget.screenShotImage.getImagePaths();
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
