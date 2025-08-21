import 'package:get/get.dart';

import '../controllers/roast_preview_screen_controller.dart';

class RoastPreviewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoastPreviewScreenController>(
      () => RoastPreviewScreenController(),
    );
  }
}
