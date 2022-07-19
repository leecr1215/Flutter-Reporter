import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reporter/models/report_item_model.dart';
import 'package:flutter_reporter/models/report_list_model.dart';
import 'package:intl/intl.dart';
import 'package:localstorage/localstorage.dart';

class BugReportWriteViewModel with ChangeNotifier {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final LocalStorage storage = LocalStorage('bug_report.json');

  BugReportList list = BugReportList();
  int index = 0;
  String title = "";
  String content = "";
  String author = "";
  String currentTime = "";
  String image = "";

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    authorController.dispose();
    super.dispose();
  }

  TextEditingController get getTitleController => titleController;
  TextEditingController get getContentController => contentController;
  TextEditingController get getAuthorController => authorController;

  void setTitle() {
    title = titleController.text;
    notifyListeners();
  }

  void setContent() {
    content = contentController.text;
    notifyListeners();
  }

  void setAuthor() {
    author = authorController.text;
    notifyListeners();
  }

  void setTime() {
    DateTime now = DateTime.now();
    currentTime = DateFormat('yyyy/MM/dd, HH:mm:ss').format(now);
    notifyListeners();
  }

  void setImage(File imageFile) {
    image = imageFile.toString().substring(7, imageFile.toString().length - 1);
    notifyListeners();
  }

  void addItem() {
    final item = BugReportItem(
        title: title,
        author: author,
        content: content,
        currentTime: currentTime,
        image: image);
    list.items.add(item);
    saveToStorage();
  }

  void saveToStorage() {
    storage.setItem('bugs$index', list.toJSONEnable());
    notifyListeners();
  }

  // 추후 삭제 기능 구현 시 필요한 함수
  void clearStorage() async {
    await storage.clear();
    list.items = storage.getItem('bugs$index') ?? [];
  }

  void saveItems(File imageFile) {
    setTitle();
    setContent();
    setAuthor();
    setTime();
    setImage(imageFile);
  }
}
