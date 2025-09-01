import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenController extends GetxController {
  RxBool isWebViewLoading = true.obs;
  RxString title = "".obs;
  WebViewController? webViewController;
  RxString webUrl = "".obs;
  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Get.arguments != null) {
        title.value = Get.arguments[ArgumentConstant.appTitle];
        webUrl.value = Get.arguments[ArgumentConstant.url];
      }
      webViewController =
          WebViewController()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setNavigationDelegate(
              NavigationDelegate(
                onProgress: (int progress) {
                  if (progress == 100) {
                    isWebViewLoading.value = false;
                  }
                },
                onPageStarted: (String url) {},
                onPageFinished: (String url) {},
                onHttpError: (HttpResponseError error) {},
                onWebResourceError: (WebResourceError error) {},
              ),
            )
            ..loadRequest(Uri.parse("$webUrl"));
    });

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
