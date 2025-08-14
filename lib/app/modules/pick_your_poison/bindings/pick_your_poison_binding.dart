import 'package:get/get.dart';

import '../controllers/pick_your_poison_controller.dart';

class PickYourPoisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PickYourPoisonController>(
      () => PickYourPoisonController(),
    );
  }
}
