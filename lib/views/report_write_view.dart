import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import 'package:flutter_reporter/view_models/metadata_app_view_model.dart';
import 'package:flutter_reporter/view_models/metadata_device_view_model.dart';
import 'package:flutter_reporter/view_models/metadata_view_model.dart';
import 'package:flutter_reporter/view_models/screen_shot_view_model.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import '../controller/bug_report_controller.dart';

class BugReportWriteView extends StatefulWidget {
  final int index;
  const BugReportWriteView({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<BugReportWriteView> createState() => _BugReportWriteViewState();
}

class _BugReportWriteViewState extends State<BugReportWriteView>
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
  late MetaDataViewModel metaDataViewModel;
  late ScreenShotViewModel screenShotViewModel;
  late AppMetaDataViewModel appModel;
  late DeviceMetaDataViewModel deviceModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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

    metaDataViewModel = Provider.of<MetaDataViewModel>(context);
    screenShotViewModel = Provider.of<ScreenShotViewModel>(context);
    appModel = Provider.of<AppMetaDataViewModel>(context);
    deviceModel = Provider.of<DeviceMetaDataViewModel>(context);

    double space = screenHeight * 0.03;

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
                      screenShotViewModel.getScreenShotImage.imagePaths[0],
                      width: screenWidth * 0.6,
                      height: screenHeight * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(space, 0, space, space),
                      child: appModel.isLoading ? appDataTable() : Container()),
                  Padding(
                      padding: EdgeInsets.fromLTRB(space, 0, space, space),
                      child: deviceModel.isLoading
                          ? deviceDataTable()
                          : Container()),
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
              alignment: Alignment.center,
              child: const Text("app name",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(appModel.appMetaData.getAppName!),
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
              child: Text(appModel.appMetaData.getPackageName!)),
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
              child: Text(appModel.appMetaData.getVersion!)),
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
              child: Text(appModel.appMetaData.getBuildNumber!)),
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
              child: Text(metaDataViewModel.flutterModeViewModel.mode)),
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
              alignment: Alignment.center,
              child: const Text("os version",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Text(
                "${deviceModel.deviceMetaData.os} ${deviceModel.deviceMetaData.osVersion}"),
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
              child: Text(deviceModel.osModel)),
        ]),
        if (deviceModel.os == "android")
          TableRow(children: [
            Container(
                height: 25,
                alignment: Alignment.center,
                child: const Text("sdk version",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Container(
                height: 25,
                alignment: Alignment.center,
                child: Text("sdk ${deviceModel.sdk}")),
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
