import 'dart:developer';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class ZoomDrawerGetXController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  final currentPage = "home".obs;

  void toggleDrawer() => zoomDrawerController.toggle?.call();
  void openDrawer() => zoomDrawerController.open?.call();
  void closeDrawer() => zoomDrawerController.close?.call();

  void changePage(String page) {
    currentPage.value = page;
    closeDrawer();
  }
}
