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
import 'package:intl/intl.dart';

class BugReportWrite extends StatefulWidget {
  final ScreenShotImage screenShotImage;
  final int index;
  BugReportWrite({Key? key, required this.screenShotImage, required this.index})
      : super(key: key);

  @override
  _BugReportWriteState createState() => _BugReportWriteState();
}

class _BugReportWriteState extends State<BugReportWrite>
    with SingleTickerProviderStateMixin {
  _BugReportWriteState({Key? key});

  //TextEditingController inputController = TextEditingController();

  String title = "";
  String content = "";
  String author = "";
  String currentTime = "";
  File imageFile = File("");

  // @override
  // void initState() {
  //   _tabController = TabController(length: 2, vsync: this);
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    imageFile = widget.screenShotImage.getImageFile(widget.index);
    return Scaffold(
        body: Center(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: Column(children: [
                Image.file(
                  imageFile,
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.4,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '제목을 입력해주세요',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (text) {
                      setTitle(text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '작성자',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (text) {
                      setAuthor(text);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '내용',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide:
                              BorderSide(width: 1, color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    onChanged: (text) {
                      setContent(text);
                    },
                  ),
                ),
                ElevatedButton(onPressed: saveItems, child: Text('저장'))
              ]),
            ),
          ),
        ),
        floatingActionButton: const BackFAB());
  }

  void setTitle(text) {
    setState(() {
      title = text;
    });
  }

  void setContent(text) {
    setState(() {
      content = text;
    });
  }

  void setAuthor(text) {
    setState(() {
      author = text;
    });
  }

  void setTime() {
    setState(() {
      DateTime now = DateTime.now();
      currentTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
    });
  }

  void saveItems() {
    setTime();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("리포트가 저장되었습니다. ")));
    print(title);
    print(author);
    print(content);
  }
}
