import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
              top: MediaQuery.of(context).padding.top + 5,
              left: 10,
              right: 10,
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
                Obx(() {
                  if (controller.historyList.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No history available",
                          style: TextStyle(
                            fontSize: MySize.getHeight(16),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.groupedHistory.keys.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, groupIndex) {
                        String dateKey = controller.groupedHistory.keys
                            .elementAt(groupIndex);
                        List<HistoryModel> items =
                            controller.groupedHistory[dateKey]!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: ColorConstants.primaryColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: ColorConstants.primaryColor,
                                      size: MySize.getHeight(18),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat(
                                          'dd MMM yyyy',
                                        ).format(DateTime.parse(dateKey)),
                                        style: TextStyle(
                                          fontSize: MySize.getHeight(13),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        "${items.length} items",
                                        style: TextStyle(
                                          fontSize: MySize.getHeight(11),
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                  ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemCount: items.length,
                              itemBuilder: (context, index) {
                                HistoryModel historyModel = items[index];
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
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: ColorConstants.primaryColor
                                              .withValues(alpha: 0.2),
                                          width: 1,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ColorConstants.primaryColor
                                                .withValues(alpha: 0.2),
                                            blurRadius: 6,
                                            spreadRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          historyModel.imageBytes,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
