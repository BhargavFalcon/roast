import 'package:get/get.dart';

import '../controllers/choose_your_targets_controller.dart';

class ChooseYourTargetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseYourTargetsController>(
      () => ChooseYourTargetsController(),
    );
  }
}
