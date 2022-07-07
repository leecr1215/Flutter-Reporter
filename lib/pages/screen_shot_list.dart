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
import 'bug_report_write.dart';

class ScreenShotListPage extends StatefulWidget {
  ScreenShotImage screenShotImage;
  ScreenShotListPage({Key? key, required this.screenShotImage})
      : super(key: key);
  //final List<File> imagePaths;

  @override
  _ScreenShotListPageState createState() => _ScreenShotListPageState();
}

class _ScreenShotListPageState extends State<ScreenShotListPage>
    with SingleTickerProviderStateMixin
    implements ScreenShotListLoader {
  late TabController _tabController;
  _ScreenShotListPageState({Key? key});

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [Tab(text: '스크린샷'), Tab(text: '리포트')];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<File> imagePaths = widget.screenShotImage.getImagePaths();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    print(imagePaths);
    return Scaffold(
        body: Container(
          padding: EdgeInsets.all(15.0),
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
                    Text('${imagePaths.length}')
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
    // TODO: 스크린샷 리스트 조회
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
}
