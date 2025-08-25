import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';

class RoastPreviewScreenController extends GetxController {
  Rx<Uint8List> uint8list = Uint8List(0).obs;

  RxList<String> roastList = <String>[].obs;

  final RxInt copiedIndex = (-1).obs;

  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments.containsKey(ArgumentConstant.imageFile)) {
      uint8list.value = Get.arguments[ArgumentConstant.imageFile];
      roastList.value = Get.arguments[ArgumentConstant.roastList] ?? [];
    }
    super.onInit();
  }
}
