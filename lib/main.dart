import 'package:flutter/material.dart';
import 'fab.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Reporter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<MainPage> {
  final GlobalKey previewContainer = GlobalKey();
  final List<String> imagePaths = [];

  @override
  void initState() {
    getImagePaths();
    super.initState();
  }

  void getImagePaths() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String nowPath = '$directory/reporter';

    /* 파일 불러와서 imagePaths에 저장 */
    List files = Directory(nowPath).listSync();
    debugPrint('파일 길이: ${files.length}');

    files.map((file) => imagePaths.add(file.toString()));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      body: RepaintBoundary(
        key: previewContainer,
        child: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text("테스트 화면입니다.")),
      ),
      floatingActionButton: FAB(
        previewContainer: previewContainer,
        imagePaths: imagePaths,
      ),
    );
  }
}
