import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter/rendering.Dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'Dart:async';
import 'Dart:typed_data';
import 'package:intl/intl.dart';
import 'Dart:ui' as ui;
import './controller/screen_shot_controller.dart';

class FAB extends StatelessWidget implements ScreenShotController {
  final GlobalKey previewContainer;
  final List<String> imagePaths;

  const FAB(
      {Key? key, required this.previewContainer, required this.imagePaths})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SpeedDial(
      elevation: 0,
      backgroundColor: Colors.black,
      icon: Icons.add,
      iconTheme: IconThemeData(size: screenWidth * 0.1),
      animatedIconTheme: IconThemeData(size: screenWidth * 0.1),
      activeIcon: Icons.close,
      buttonSize: Size(screenWidth * 0.13, screenWidth * 0.13),
      childrenButtonSize: Size(screenWidth * 0.13, screenWidth * 0.13),
      spaceBetweenChildren: 6,
      childPadding: const EdgeInsets.all(0),
      overlayOpacity: 0,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.photo_camera,
            size: screenWidth * 0.13,
          ),
          onTap: () {
            takeScreenShot();
          },
        ),
        SpeedDialChild(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Icon(
              Icons.folder_open,
              size: screenWidth * 0.13,
            ),
            onTap: () async {}),
      ],
    );
  }

  /* 스크린 샷 찍는 함수 */
  @override
  void takeScreenShot() async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      if (previewContainer.currentContext != null) {
        RenderRepaintBoundary? boundary = previewContainer.currentContext!
            .findRenderObject() as RenderRepaintBoundary?;
        ui.Image image = await boundary!.toImage();
        final directory = (await getApplicationDocumentsDirectory()).path;
        /* 이미지 저장할 폴더인 reporter 생성 */
        Directory newDirectory =
            await Directory('$directory/reporter').create(recursive: true);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        DateTime now = DateTime.now();
        String currentTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
        File imgFile =
            File('$directory/reporter/${currentTime}_screenshot.png');
        imgFile.writeAsBytes(pngBytes);
        imagePaths.add('$directory/reporter/${currentTime}_screenshot.png');
        debugPrint(imagePaths[23]);
        debugPrint('캡처 번호: ${imagePaths.length}');
      }
    });
  }
}
