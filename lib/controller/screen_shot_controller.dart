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
import '../controller/screen_shot_controller.dart';
import '../pages/screen_shot_list.dart';

abstract class ScreenShotController {
  void takeScreenShot();
}

class ScreenShotImage implements ScreenShotController {
  final GlobalKey _previewContainer;
  List<File> _imagePaths;
  ScreenShotImage(this._previewContainer, this._imagePaths);
  //GlobalKey get previewContainer => _previewContainer;
  //set previewContainer(GlobalKey previewContainer) => _previewContainer = previewContainer;

  void setImagePaths(List<File> newImagePaths) {
    _imagePaths = newImagePaths;
  }

  List<File> getImagePaths() {
    return _imagePaths;
  }

  GlobalKey getGlobalKey() {
    return _previewContainer;
  }

  File getImageFile(int index) {
    return _imagePaths[index];
  }

  @override
  void takeScreenShot() async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      if (_previewContainer.currentContext != null) {
        RenderRepaintBoundary? boundary = _previewContainer.currentContext!
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
            File('$directory\\reporter/${currentTime}_screenshot.png');
        imgFile.writeAsBytes(pngBytes);
        _imagePaths
            .add(File('$directory/reporter/${currentTime}_screenshot.png'));
        //debugPrint(imagePaths[0]);
        debugPrint('캡처 번호: ${_imagePaths.length}');
      }
    });
  }
}