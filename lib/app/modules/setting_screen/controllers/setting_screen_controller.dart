import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreenController extends GetxController {
  RxString appVersion = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppVersion();
  }

  Future<void> _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion.value = "${info.version} (${info.buildNumber})";
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
