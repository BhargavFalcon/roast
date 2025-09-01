import 'package:flutter/cupertino.dart' show CupertinoActivityIndicator;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/web_view_screen_controller.dart';

class WebViewScreenView extends GetWidget<WebViewScreenController> {
  const WebViewScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WebViewScreenController>(
      init: WebViewScreenController(),
      assignId: true,
      builder: (controller) {
        return Obx(() {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                controller.title.value,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
            ),
            body:
                (controller.isWebViewLoading.isTrue)
                    ? Center(
                      child: CupertinoActivityIndicator(
                        color: ColorConstants.primaryColor,
                      ),
                    )
                    : WebViewWidget(controller: controller.webViewController!),
          );
        });
      },
    );
  }
}
