import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import '../controller/screen_shot_list_loader.dart';
import 'dart:io';
import '../controller/screen_shot_controller.dart';
import 'bug_report_write.dart';
import 'package:localstorage/localstorage.dart';
import '../controller/bug_report_list_loader.dart';
import 'bug_report_list.dart';
import '../controller/metadata_controller.dart';

class ScreenShotListPage extends StatefulWidget {
  final ScreenShotImage screenShotImage;
  const ScreenShotListPage({Key? key, required this.screenShotImage})
      : super(key: key);
  @override
  State<ScreenShotListPage> createState() => _ScreenShotListPageState();
}

class _ScreenShotListPageState extends State<ScreenShotListPage>
    with SingleTickerProviderStateMixin
    implements ScreenShotListLoader {
  late TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);

  final _tabs = [const Tab(text: '스크린샷'), const Tab(text: '리포트')];
  LocalStorage storage = LocalStorage('bug_report.json');

  Map<String, dynamic> map = {};

  late BugReport bugReport;
  late MetaDataInfo metaDataInfo;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    waitStorageReady();
    bugReport = BugReport();
    metaDataInfo = MetaDataInfo();

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

    debugPrint(bugReport.keys.toString());
    return Scaffold(
        body: SafeArea(
          child: Container(
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
                  indicatorPadding: const EdgeInsets.all(5.0),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: _selectedColor),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      showScreenShotList(),
                      BugReportList(bugReport: bugReport)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: const Align(
          alignment: Alignment.bottomLeft,
          child: BackFAB(),
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
                          screenShotImage: widget.screenShotImage,
                          index: index,
                          metaDataInfo: metaDataInfo,
                        )),
              );
            },
            child: Image.file(
              imagePaths[index],
              fit: BoxFit.fill,
            ));
      },
    );
  }
}
