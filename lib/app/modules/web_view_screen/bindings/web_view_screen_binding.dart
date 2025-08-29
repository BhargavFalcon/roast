import 'package:get/get.dart';

import '../controllers/web_view_screen_controller.dart';

class WebViewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebViewScreenController>(
      () => WebViewScreenController(),
    );
  }
}
