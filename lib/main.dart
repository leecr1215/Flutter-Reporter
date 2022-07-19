import 'package:flutter/material.dart';
import 'package:flutter_reporter/controller/screen_shot_controller.dart';
import 'components/debug_fab.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'test_app.dart';

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
    return Scaffold(

      body: SafeArea(
        child: Stack(
          children: [
            Navigator(
              onGenerateRoute: (routeSettings) {
                return MaterialPageRoute(
                    builder: (context) => RepaintBoundary(
                        key: screenShotImage.getGlobalKey(),
                        child: const TestApp()));
              },
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: FAB(screenShotImage: screenShotImage),
            )
          ],
        ),

      ),
    );
  }
}
