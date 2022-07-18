import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/rendering.Dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class ScreenShotImage {
  final globalKey = GlobalKey();
  late final List<File> imagePaths = [];
}
