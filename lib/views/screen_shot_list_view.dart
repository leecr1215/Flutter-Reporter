import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import 'package:flutter_reporter/view_models/metadata_app_view_model.dart';
import 'package:flutter_reporter/view_models/metadata_device_view_model.dart';
import 'package:flutter_reporter/view_models/metadata_view_model.dart';
import 'package:flutter_reporter/view_models/report_list_view_model.dart';
import 'package:flutter_reporter/view_models/report_write_view_model.dart';
import 'package:flutter_reporter/view_models/screen_shot_view_model.dart';
import 'package:flutter_reporter/views/report_list_view.dart';
import 'package:flutter_reporter/views/report_write_view.dart';
import 'dart:io';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';

class ScreenShotListView extends StatefulWidget {
  const ScreenShotListView({Key? key}) : super(key: key);
  @override
  State<ScreenShotListView> createState() => _ScreenShotListViewState();
}

class _ScreenShotListViewState extends State<ScreenShotListView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = const Color(0xff1a73e8);

  final _tabs = [const Tab(text: '스크린샷'), const Tab(text: '리포트')];
  LocalStorage storage = LocalStorage('bug_report.json');

  Map<String, dynamic> map = {};

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    waitStorageReady();
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
                      ChangeNotifierProvider<BugReportListViewModel>(
                          create: (_) => BugReportListViewModel(),
                          child: const BugReportListView())
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

  showScreenShotList() {
    // 스크린샷 리스트 조회 child
    ScreenShotViewModel screenShotViewModel =
        Provider.of<ScreenShotViewModel>(context);
    final List<File> imagePaths =
        screenShotViewModel.getScreenShotImage.imagePaths;
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
                  builder: (context) => MultiProvider(providers: [
                    ChangeNotifierProvider<MetaDataViewModel>(
                      create: (context) => MetaDataViewModel(),
                    ),
                    ChangeNotifierProvider<ScreenShotViewModel>(
                      create: (context) => ScreenShotViewModel(),
                    ),
                    ChangeNotifierProvider<AppMetaDataViewModel>(
                      create: (context) => AppMetaDataViewModel(),
                    ),
                    ChangeNotifierProvider<DeviceMetaDataViewModel>(
                      create: (context) => DeviceMetaDataViewModel(),
                    ),
                    ChangeNotifierProvider<BugReportWriteViewModel>(
                      create: (context) => BugReportWriteViewModel(),
                    ),
                  ], child: BugReportWriteView(index: index)),
                ),
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
