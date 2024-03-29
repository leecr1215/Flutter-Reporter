import 'package:flutter/material.dart';
import 'package:flutter_reporter/components/debug_fab.dart';
import 'package:flutter_reporter/main.dart';
import 'package:flutter_reporter/test_app.dart';
import 'package:flutter_reporter/view_models/screen_shot_view_model.dart';
import 'package:provider/provider.dart';

ScreenShotViewModel screenShotViewModel = ScreenShotViewModel();

class MainView extends State<Home> {
  @override
  void initState() {
    screenShotViewModel.getImagePaths();
    super.initState();
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
                        key: screenShotViewModel.getScreenShotImage.globalKey,
                        child: const TestApp()));
              },
            ),
            Positioned(
              bottom: 15,
              right: 15,
              child: ChangeNotifierProvider<ScreenShotViewModel>(
                  create: (context) => screenShotViewModel, child: const FAB()),
            )
          ],
        ),
      ),
    );
  }
}
