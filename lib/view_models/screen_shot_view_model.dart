import 'package:flutter/widgets.dart';
import 'package:flutter_reporter/models/screen_shot_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.Dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ScreenShotViewModel with ChangeNotifier {
  static final ScreenShotImage screenShotImage = ScreenShotImage();
  bool _disposed = false;

  void getImagePaths() {
    List<File> imagePaths = [];
    Future<List> files = getLocalImagePaths();
    files.then((file) => {
          file.map((file) => imagePaths.add(file)).toList(),
          screenShotImage.imagePaths = imagePaths,
        });
  }

  ScreenShotImage get getScreenShotImage => screenShotImage;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  File getImageFile(int index) {
    return screenShotImage.imagePaths[index];
  }

  void setImagePaths(List<File> newImagePaths) {
    screenShotImage.imagePaths = newImagePaths;
  }

  void takeScreenShot() async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      if (screenShotImage.globalKey.currentContext != null) {
        RenderRepaintBoundary? boundary =
            screenShotImage.globalKey.currentContext!.findRenderObject()
                as RenderRepaintBoundary?;
        ui.Image image = await boundary!.toImage();
        final directory = (await getApplicationDocumentsDirectory()).path;
        /* 이미지 저장할 폴더인 reporter 생성 */
        await Directory('$directory/reporter').create(recursive: true);
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();
        DateTime now = DateTime.now();

        String currentTime = DateFormat('yyyy-MM-dd_HH-mm-ss').format(now);
        File imgFile =
            File('$directory/reporter/${currentTime}_screenshot.png');
        imgFile.writeAsBytes(pngBytes);
        screenShotImage.imagePaths
            .add(File('$directory/reporter/${currentTime}_screenshot.png'));

        debugPrint('캡처 번호: ${screenShotImage.imagePaths.length}');
      }
    });
    notifyListeners();
  }

  Future<List> getLocalImagePaths() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    String nowPath = '$directory/reporter';

    /* 파일 불러와서 imagePaths에 저장 */
    List<FileSystemEntity> files = Directory(nowPath).listSync();
    debugPrint('파일 길이: ${files.length}');

    return files;
  }
}
