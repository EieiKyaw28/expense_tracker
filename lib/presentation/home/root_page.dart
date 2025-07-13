import 'dart:developer';

import 'package:expense_tracker/common/common_app_bar.dart';
import 'package:expense_tracker/common/common_scaffold.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/presentation/history/history_page.dart';
import 'package:expense_tracker/presentation/home/create_page.dart';
import 'package:expense_tracker/presentation/home/home_page.dart';
import 'package:expense_tracker/presentation/note/note_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ZoomDrawerGetXController>(
      builder: (drawerController) {
        log("Current Page : ${drawerController.currentPage.value}");
        return CommonScaffold(
          body: Obx(
            () {
              switch (drawerController.currentPage.value) {
                case 'history':
                  return const HistoryPage();
                case 'home':
                  return const HomePage();
                case 'create':
                  return const CreatePage();
                case 'note':
                  return const NotePage();
                default:
                  return const HomePage();
              }
            },
          ),
        );
      },
    );
  }
}
