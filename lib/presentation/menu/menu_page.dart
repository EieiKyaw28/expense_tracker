import 'package:expense_tracker/constant/extensions.dart';
import 'package:expense_tracker/constant/my_image.dart';
import 'package:expense_tracker/constant/my_theme.dart';
import 'package:expense_tracker/controller/zoom_controller.dart';
import 'package:expense_tracker/domain/menu_model.dart';
import 'package:expense_tracker/presentation/chart/chart_page.dart';
import 'package:expense_tracker/presentation/history/history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({
    super.key,
  });

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    final drawerController = Get.find<ZoomDrawerGetXController>();

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.vGap,
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: const Icon(Icons.person,
                      color: MyTheme.primaryColor, size: 50)),
              10.vGap,
              const Text("User Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              30.vGap,
              const Divider(),
              ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: InkWell(
                        onTap: () {
                          drawerController
                              .changePage(menuList[index].title.toLowerCase());
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              menuList[index].image,
                              height: 30,
                              width: 30,
                              color: MyTheme.primaryColor,
                            ),
                            20.hGap,
                            Text(
                              menuList[index].title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: menuList.length),
              20.vGap,
            ],
          ),
        ),
      ),
    );
  }
}

List<MenuModel> menuList = [
  MenuModel(
    title: "Home",
    image: MyImage.homeIcon,
    route: Container(),
  ),
  MenuModel(
    title: "Note",
    image: MyImage.noteIcon,
    route: Container(),
  ),
  MenuModel(
    title: "History",
    image: MyImage.historyIcon,
    route: const HistoryPage(),
  ),
  // MenuModel(
  //   title: "Chart",
  //   image: MyImage.chartIcon,
  //   route: const ChartPage(),
  // ),
  MenuModel(
    title: "Theme",
    image: MyImage.themeIcon,
    route: Container(),
  ),
  // MenuModel(
  //   title: "Profile",
  //   image: MyImage.profileIcon,
  //   route: Container(),
  // ),
  // MenuModel(
  //   title: "Setting",
  //   image: MyImage.settingIcon,
  //   route: Container(),
  // ),
  // MenuModel(
  //   title: "Logout",
  //   image: MyImage.logoutIcon,
  //   route: Container(),
  // ),
];
