import 'dart:async';

import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/presentation/home/root_page.dart';
import 'package:expense_tracker/presentation/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
 

  @override
  Widget build(BuildContext context) {
    final drawerController = Get.put(ZoomDrawerGetXController());

    return ZoomDrawer(
      menuBackgroundColor: Colors.white,
      controller: drawerController.zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: const MenuPage(),
      mainScreen: const RootPage(), // Notice: RootPage is now the *main screen*
      borderRadius: 10.0,
      showShadow: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * .5,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}
