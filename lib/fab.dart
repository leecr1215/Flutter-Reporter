import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

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
            onTap: () => print("CAPTURE")),
        SpeedDialChild(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Icon(
              Icons.folder_open,
              size: screenWidth * 0.13,
            ),
            onTap: () => print("FILE")),
      ],
    );
  }
}
