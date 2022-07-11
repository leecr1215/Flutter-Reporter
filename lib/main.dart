import 'package:flutter/material.dart';
import 'package:flutter_reporter/controller/screen_shot_controller.dart';
import 'components/debug_fab.dart';
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
  const MainPage({Key? key}) : super(key: key);
  @override
  MyHomePage createState() => MyHomePage();
}

class MyHomePage extends State<MainPage> {
  final List<File> imagePaths = [];
  ScreenShotImage screenShotImage = ScreenShotImage(GlobalKey(), []);

  @override
  void initState() {
    Future<List> files = getImagePaths();

    files.then((file) => {
          file.map((file) => imagePaths.add(file)).toList(),
          screenShotImage.setImagePaths(imagePaths)
        });

    print('가져온 imagePaths: ${screenShotImage.getImagePaths()}');
    super.initState();
  }

  Future<List> getImagePaths() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String nowPath = '$directory/reporter';

    /* 파일 불러와서 imagePaths에 저장 */
    List<FileSystemEntity> files = Directory(nowPath).listSync();
    debugPrint('파일 길이: ${files.length}');

    return files;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: RepaintBoundary(
        key: screenShotImage.getGlobalKey(),
        child: Container(
            width: screenWidth,
            height: screenHeight,
            decoration: const BoxDecoration(color: Colors.blue),
            child: const Text("테스트 화면입니다")),
      ),
      floatingActionButton: FAB(screenShotImage: screenShotImage),
    );
  }
}
