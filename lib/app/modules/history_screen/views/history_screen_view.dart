import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/model/historyModel.dart';
import 'package:roast/app/routes/app_pages.dart';

import '../controllers/history_screen_controller.dart';

class HistoryScreenView extends GetView<HistoryScreenController> {
  const HistoryScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<HistoryScreenController>(
        init: HistoryScreenController(),
        assignId: true,
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "History",
                      style: TextStyle(
                        fontSize: MySize.getHeight(24),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConstants.primaryColor.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            ImageConstant.medium,
                            height: MySize.getHeight(20),
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: MySize.getHeight(13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                if (controller.historyList.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        "No history available",
                        style: TextStyle(
                          fontSize: MySize.getHeight(16),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                if (controller.historyList.isNotEmpty)
                  Expanded(
                    child: Obx(() {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        padding: EdgeInsets.zero,
                        itemCount: controller.historyList.length,
                        itemBuilder: (context, index) {
                          HistoryModel historyModel =
                              controller.historyList[index];
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.ROAST_PREVIEW_SCREEN,
                                  arguments: {
                                    ArgumentConstant.imageFile:
                                        historyModel.imageBytes,
                                    ArgumentConstant.roastList:
                                        historyModel.roastList,
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.memory(
                                  controller.historyList[index].imageBytes!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
