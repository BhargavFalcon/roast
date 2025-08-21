import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';

import '../controllers/roast_preview_screen_controller.dart';

class RoastPreviewScreenView extends GetWidget<RoastPreviewScreenController> {
  const RoastPreviewScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const SizedBox(width: 8),
              Icon(Icons.arrow_back_ios, color: ColorConstants.primaryColor),
              Text(
                "Back",
                style: TextStyle(
                  color: ColorConstants.primaryColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 100,
        centerTitle: true,
        title: const Text(
          '🔥 Roasts',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Image.asset(
            ImageConstant.share,
            height: 24,
            color: ColorConstants.primaryColor,
          ),
          const SizedBox(width: 30),
          Image.asset(
            ImageConstant.delete,
            height: 24,
            color: ColorConstants.primaryColor,
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Center(child: _ImagePreview(context)),
                SizedBox(height: MySize.getHeight(20)),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.roastList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: ColorConstants.primaryColor.withValues(
                            alpha: 0.2,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.primaryColor.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              controller.roastList[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(() {
                            bool isCopied =
                                controller.copiedIndex.value == index;
                            return InkWell(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: controller.roastList[index],
                                  ),
                                );
                                controller.copiedIndex.value = index;
                                Future.delayed(const Duration(seconds: 1), () {
                                  controller.copiedIndex.value = -1;
                                });
                              },
                              child:
                                  isCopied
                                      ? Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 22,
                                      )
                                      : Image.asset(
                                        ImageConstant.copy,
                                        height: 20,
                                        color: ColorConstants.primaryColor,
                                      ),
                            );
                          }),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: MySize.getHeight(10));
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _ImagePreview(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.file(
          controller.imageFile.value!,
          fit: BoxFit.cover,
          height: MySize.getHeight(200),
        ),
      ),
    );
  }
}
