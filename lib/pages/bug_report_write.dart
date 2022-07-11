import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/back_fab.dart';
import 'package:flutter_reporter/pages/screen_shot_list.dart';
import 'dart:io';
import '../controller/screen_shot_controller.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';
import '../controller/bug_report_controller.dart';

class BugReportWrite extends StatefulWidget {
  final ScreenShotImage screenShotImage;
  final int index;
  const BugReportWrite(
      {Key? key, required this.screenShotImage, required this.index})
      : super(key: key);

  @override
  State<BugReportWrite> createState() => _BugReportWriteState();
}

class _BugReportWriteState extends State<BugReportWrite>
    with SingleTickerProviderStateMixin
    implements BugReportController {
  final BugReportList list = BugReportList();
  final LocalStorage storage = LocalStorage('bug_report.json');

  String title = "";
  String content = "";
  String author = "";
  String currentTime = "";
  List<File> imageFile = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    imageFile.add(widget.screenShotImage.getImageFile(widget.index));
    double space = screenHeight * 0.05;
    //debugPrint('인덱스 : ${widget.index}');
    return Scaffold(
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(space),
                    child: Image.file(
                      imageFile[0],
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.4,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(space, 0, space, space),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '제목을 입력해주세요',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                    padding: EdgeInsets.fromLTRB(space, 0, space, space),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '작성자',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                    padding: EdgeInsets.fromLTRB(space, 0, space, space),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: '내용',
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * 0.02),
                    child: ElevatedButton(
                      onPressed: saveItems,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(80, 50),
                      ),
                      child: const Text('저장'),
                    ),
                  )
                ]),
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
    // 빈칸 없는지 확인
    if (title == "" || author == "" || content == "") {
      alertDialog();
    } else {
      // 시간되면 저장된 리포트인지 아닌지 판단
      // 저장
      setTime();
      addItem();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("리포트가 저장되었습니다. ")));
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScreenShotListPage(screenShotImage: widget.screenShotImage)),
      );
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
