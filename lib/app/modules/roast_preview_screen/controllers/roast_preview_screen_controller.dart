import 'dart:io';

import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';

class RoastPreviewScreenController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);

  RxList<String> roastList = <String>[].obs;

  final RxInt copiedIndex = (-1).obs;

  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments.containsKey(ArgumentConstant.imageFile)) {
      imageFile.value = Get.arguments[ArgumentConstant.imageFile];
      roastList.value = Get.arguments[ArgumentConstant.roastList] ?? [];
    }
    super.onInit();
  }
}
