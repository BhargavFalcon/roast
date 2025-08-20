import 'dart:io';

import 'package:get/get.dart';
import 'package:roast/app/constants/image_constants.dart';

class RoastScreenController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  RxList<BurnModel> burnLevelList =
      <BurnModel>[
        BurnModel(
          label: "medium",
          selectedIcon: ImageConstant.fill_medium,
          unselectedIcon: ImageConstant.medium,
          isSelected: true,
        ),
        BurnModel(
          label: "high",
          selectedIcon: ImageConstant.fill_high,
          unselectedIcon: ImageConstant.high,
          isSelected: false,
        ),
        BurnModel(
          label: "extreme",
          selectedIcon: ImageConstant.fill_extreme,
          unselectedIcon: ImageConstant.extreme,
          isSelected: false,
        ),
      ].obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class BurnModel {
  String label;
  String selectedIcon;
  String unselectedIcon;
  RxBool isSelected = false.obs;

  BurnModel({
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
    bool isSelected = false,
  }) {
    this.isSelected.value = isSelected;
  }
}
