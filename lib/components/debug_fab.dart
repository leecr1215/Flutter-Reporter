import 'package:flutter/material.dart';
//import 'package:flutter_reporter/controller/screen_shot_controller.dart';
import 'package:flutter_reporter/view_models/screen_shot_view_model.dart';

import 'package:flutter_reporter/views/screen_shot_list_view.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class FAB extends StatelessWidget {
  const FAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    ScreenShotViewModel screenViewModel =
        Provider.of<ScreenShotViewModel>(context);

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
            screenViewModel.takeScreenShot();
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text("스크린샷이 저장되었습니다.")));
          },
        ),
        SpeedDialChild(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Icon(
              Icons.folder_open,
              size: screenWidth * 0.13,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<
                            ScreenShotViewModel>(
                        create: (context) => ScreenShotViewModel(),
                        // create: (context) -> screenViewModel() 하면 뒤로가기 잘됨..
                        child: const ScreenShotListView())),
              );
            }),
      ],
    );
  }
}
