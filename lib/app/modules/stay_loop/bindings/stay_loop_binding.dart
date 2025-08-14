import 'package:get/get.dart';

import '../controllers/stay_loop_controller.dart';

class StayLoopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StayLoopController>(
      () => StayLoopController(),
    );
  }
}
