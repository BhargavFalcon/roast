import 'package:get/get.dart';

import '../controllers/roast_screen_controller.dart';

class RoastScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoastScreenController>(
      () => RoastScreenController(),
    );
  }
}
