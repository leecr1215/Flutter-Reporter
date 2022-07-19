import 'package:flutter/material.dart';

class TestApp extends StatelessWidget {
  const TestApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(color: Colors.purple.shade100),
        child: Column(
          children: [
            const Text("테스트 화면1입니다"),
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
                child: const Text("다음페이지로"))
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
        decoration: const BoxDecoration(color: Colors.yellow),
        child: Column(
          children: [
            const Text("테스트 화면2입니다"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("전페이지로")),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestApp3(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight)),
                  );
                },
                child: const Text("다음페이지로"))
          ],
        ));
  }
}

class TestApp3 extends StatelessWidget {
  const TestApp3({
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
        decoration: const BoxDecoration(color: Colors.orange),
        child: Column(
          children: [
            const Text("테스트 화면3입니다"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("전페이지로"))
          ],
        ));
  }
}
