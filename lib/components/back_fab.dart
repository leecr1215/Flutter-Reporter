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
import '../controller/screen_shot_controller.dart';

class BackFAB extends StatelessWidget {
  const BackFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
          margin: const EdgeInsets.only(left: 30),
          child: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.keyboard_backspace))),
    );
  }
}
