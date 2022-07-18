import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import 'dart:io';
import '../controller/screen_shot_controller.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '../controller/bug_report_controller.dart';
import '../controller/metadata_controller.dart';

class BugReportWrite extends StatefulWidget {
  final ScreenShotImage screenShotImage;
  final int index;
  final DeviceMetaData deviceMetaData;
  const BugReportWrite(
      {Key? key,
      required this.screenShotImage,
      required this.index,
      required this.deviceMetaData})
      : super(key: key);

  @override
  State<BugReportWrite> createState() => _BugReportWriteState();
}

class _BugReportWriteState extends State<BugReportWrite>
    with SingleTickerProviderStateMixin
    implements BugReportController {
  final BugReportList list = BugReportList();
  final LocalStorage storage = LocalStorage('bug_report.json');
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final authorController = TextEditingController();

  String title = "";
  String content = "";
  String author = "";
  String currentTime = "";
  List<File> imageFile = [];
  late AppMetaData appMetaData;
  late FlutterMode mode;

  @override
  void initState() {
    appMetaData = AppMetaData();
    mode = FlutterMode();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    imageFile.add(widget.screenShotImage.getImageFile(widget.index));
    double space = screenHeight * 0.03;
    //debugPrint('인덱스 : ${widget.index}');
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(space),
                    child: Image.file(
                      imageFile[0],
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(space, 0, space, space),
                    child: FutureBuilder<dynamic>(
                        future: appMetaData.setVersionInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return appDataTable();
                          } else {
                            return const Text("값을 불러올 수 없습니다.");
                          }
                        }),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(space, 0, space, space),
                      child: deviceDataTable()),
                  Container(
                      padding: EdgeInsets.only(bottom: space),
                      width: 500,
                      child:
                          Divider(color: Colors.grey.shade400, thickness: 1.0)),
                  SizedBox(
                    height: 75,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(space, 0, space, space),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: '제목',
                          labelStyle: TextStyle(fontSize: 13),
                          hintStyle: TextStyle(fontSize: 13),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: titleController,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(space, 0, space, space),
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: '작성자',
                          hintStyle: TextStyle(fontSize: 13),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.black)),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        controller: authorController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(space, 0, space, space),
                    child: TextField(
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: '내용',
                        hintStyle: TextStyle(fontSize: 13),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide:
                                BorderSide(width: 1, color: Colors.black)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                      controller: contentController,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.02, bottom: screenHeight * 0.02),
                    child: ElevatedButton(
                      onPressed: saveItems,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(70, 50),
                      ),
                      child: const Text("저장"),
                    ),
                  ),
                ]),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpened,
        child: const BackFAB(),
      ),
    );
  }

  Table appDataTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: <TableRow>[
        TableRow(children: [
          Container(
              height: 25,
              //color: Colors.grey.shade400,
              alignment: Alignment.center,
              child: const Text("app name",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text("${appMetaData.appName}"),
          ),
        ]),
        TableRow(children: [
          Container(
              height: 25,
              alignment: Alignment.center,
              child: const Text("package name",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              height: 25,
              alignment: Alignment.center,
              child: Text("${appMetaData.packageName}")),
        ]),
        TableRow(children: [
          Container(
              height: 25,
              alignment: Alignment.center,
              child: const Text("package version",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              height: 25,
              alignment: Alignment.center,
              child: Text("${appMetaData.version}")),
        ]),
        TableRow(children: [
          Container(
              height: 25,
              alignment: Alignment.center,
              child: const Text("build number",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              height: 25,
              alignment: Alignment.center,
              child: Text("${appMetaData.buildNumber}")),
        ]),
        TableRow(children: [
          Container(
              height: 25,
              alignment: Alignment.center,
              child: const Text("build mode",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              height: 25,
              alignment: Alignment.center,
              child: Text("${mode.mode}")),
        ]),
      ],
    );
  }

  Table deviceDataTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: <TableRow>[
        TableRow(children: [
          Container(
              height: 25,
              //color: Colors.grey.shade400,
              alignment: Alignment.center,
              child: const Text("os version",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(
                "${widget.deviceMetaData.os} ${widget.deviceMetaData.osVersion}"),
          ),
        ]),
        TableRow(children: [
          Container(
              height: 25,
              alignment: Alignment.center,
              child: const Text("model",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
              height: 25,
              alignment: Alignment.center,
              child: Text("${widget.deviceMetaData.osModel}")),
        ]),
        if (widget.deviceMetaData.os == "android")
          TableRow(children: [
            Container(
                height: 25,
                alignment: Alignment.center,
                child: const Text("sdk version",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Container(
                height: 25,
                alignment: Alignment.center,
                child: Text("sdk ${widget.deviceMetaData.sdk}")),
          ]),
      ],
    );
  }

  void setTitle() {
    setState(() {
      title = titleController.text;
    });
  }

  void setContent() {
    setState(() {
      content = contentController.text;
    });
  }

  void setAuthor() {
    setState(() {
      author = authorController.text;
    });
  }

  void setTime() {
    setState(() {
      DateTime now = DateTime.now();
      currentTime = DateFormat('yyyy/MM/dd, HH:mm:ss').format(now);
    });
  }

  void addItem() {
    final item = BugReportItem(
        title: title,
        author: author,
        content: content,
        currentTime: currentTime,
        image: imageFile[0]
            .toString()
            .substring(7, imageFile[0].toString().length - 1));
    list.items.add(item);
    saveToStorage();

    // file을 string으로 바꿀 때 사용
    debugPrint(imageFile[0]
        .toString()
        .substring(7, imageFile[0].toString().length - 1));
  }

  void saveToStorage() {
    storage.setItem('bugs${widget.index}', list.toJSONEnable());
  }

  // 추후 삭제 기능 구현 시 필요한 함수
  void clearStorage() async {
    await storage.clear();

    setState(() {
      list.items = storage.getItem('bugs${widget.index}') ?? [];
    });
  }

  @override
  void saveItems() {
    setTitle();
    setContent();
    setAuthor();
    setTime();
    // 빈칸 없는지 확인
    if (title == "" || author == "" || content == "") {
      alertDialog();
    } else {
      // 시간되면 저장된 리포트인지 아닌지 판단
      // 저장

      addItem();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("리포트가 저장되었습니다. ")));
      Navigator.pop(context);
    }
  }

  Future<dynamic> alertDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: const Text("빈칸없이 작성해주세요"),
            actions: [
              Center(
                  child: TextButton(
                child: const Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ))
            ],
          );
        });
  }
}
