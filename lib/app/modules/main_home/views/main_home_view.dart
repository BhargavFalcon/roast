import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/modules/history_screen/views/history_screen_view.dart';
import 'package:roast/app/modules/roast_screen/views/roast_screen_view.dart';
import 'package:roast/app/modules/setting_screen/views/setting_screen_view.dart';

import '../../../constants/image_constants.dart';
import '../controllers/main_home_controller.dart';

class MainHomeView extends GetWidget<MainHomeController> {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      MySize().init(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          children: [
            RoastScreenView(),
            HistoryScreenView(),
            SettingScreenView(),
          ],
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory, // ripple disable
            highlightColor: Colors.transparent, // tap highlight disable
          ),
          child: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            selectedLabelStyle: TextStyle(
              fontSize: MySize.getHeight(12),
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontSize: MySize.getHeight(12),
              fontWeight: FontWeight.bold,
            ),
            selectedItemColor: ColorConstants.primaryColor,
            unselectedItemColor: Colors.grey,
            elevation: 0,
            onTap: controller.changeTab,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageConstant.fill_medium,
                  height: MySize.getHeight(20),
                  color:
                      (controller.selectedIndex.value == 0)
                          ? ColorConstants.primaryColor
                          : Colors.grey,
                ),
                label: "Roast",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageConstant.history,
                  height: MySize.getHeight(20),
                  color:
                      (controller.selectedIndex.value == 1)
                          ? ColorConstants.primaryColor
                          : Colors.grey,
                ),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  ImageConstant.settings,
                  height: MySize.getHeight(20),
                  color:
                      (controller.selectedIndex.value == 2)
                          ? ColorConstants.primaryColor
                          : Colors.grey,
                ),
                label: "Settings",
              ),
            ],
          ),
        ),
      );
    });
  }
}
