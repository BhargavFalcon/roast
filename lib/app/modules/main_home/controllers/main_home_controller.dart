import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends GetxController {
  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();
  final List<Widget> pages = [
    const Center(child: Text("Roast Screen", style: TextStyle(fontSize: 22))),
    const Center(child: Text("History Screen", style: TextStyle(fontSize: 22))),
    const Center(
      child: Text("Settings Screen", style: TextStyle(fontSize: 22)),
    ),
  ];
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestTrackingPermission();
    });
    super.onInit();
  }

  Future<void> requestTrackingPermission() async {
    if (Platform.isIOS) {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    }
  }

  void changeTab(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
