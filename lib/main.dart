import 'package:flutter/material.dart';
import 'fab.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final GlobalKey previewContainer = GlobalKey();

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
      ),
    );
  }
}
