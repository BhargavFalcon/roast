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
    super.onInit();
  }



  void changeTab(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index);
  }
}
