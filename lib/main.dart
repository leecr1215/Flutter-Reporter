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
      home: const MainPage(),
      // builder: (context, widget) {
      //   return FloatingActionButton(onPressed: () {}, child: widget);
      // },
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

    debugPrint('가져온 imagePaths: ${screenShotImage.getImagePaths()}');
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

        child: TestApp(screenWidth: screenWidth, screenHeight: screenHeight),
            decoration: const BoxDecoration(color: Colors.yellow),
            child: const Text("테스트 화면입니다.")),
      ),
      floatingActionButton: FAB(screenShotImage: screenShotImage),
      // bottomNavigationBar: BottomAppBar,
    );
  }
}

class TestApp extends StatelessWidget {
  const TestApp({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(color: Colors.purple.shade100),
        child: Column(
          children: [
            const Text("테스트 화면입니다"),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestApp2(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight)),
                  );
                },
                child: Text("다음페이지로"))
          ],
        ));
  }
}

class TestApp2 extends StatelessWidget {
  const TestApp2({
    Key? key,
    required this.screenWidth,
    required this.screenHeight,
  }) : super(key: key);

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(color: Colors.yellow),
        child: Column(
          children: [
            const Text("테스트 화면입니다"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("전페이지로"))
          ],
        ));
  }
}
