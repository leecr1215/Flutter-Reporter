import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.Dart';
import 'package:flutter/services.Dart';
import 'package:path_provider/path_provider.dart';
import 'Dart:io';
import 'Dart:async';
import 'Dart:typed_data';
import 'Dart:ui' as ui;

class ScreenshotListPage extends StatefulWidget {
  const ScreenshotListPage({Key? key}) : super(key: key);

  @override
  _ScreenshotListPageState createState() => _ScreenshotListPageState();
}

class _ScreenshotListPageState extends State<ScreenshotListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(8.0),
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
                  Container(child: Center(child: Text('people'))),
                  Text('Person')
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   double screenWidth = MediaQuery.of(context).size.width;
  //   double screenHeight = MediaQuery.of(context).size.height;

  //   return Scaffold(
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: ListView(
  //         children: [
  //           Container(
  //               height: screenHeight * 0.2,
  //               decoration: BoxDecoration(
  //                 color: Colors.transparent,
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: TabBar(
  //                   controller: _tabController,
  //                   indicator: BoxDecoration(
  //                       borderRadius: BorderRadius.circular(10.0),
  //                       color: _selectedColor),
  //                   labelColor: Colors.white,
  //                   unselectedLabelColor: Colors.black,
  //                   tabs: _tabs))
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
