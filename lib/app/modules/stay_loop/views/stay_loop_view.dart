import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/daily_Notifications.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/main.dart';

import '../../../routes/app_pages.dart';
import '../controllers/stay_loop_controller.dart';

class StayLoopView extends GetView<StayLoopController> {
  const StayLoopView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + MySize.getHeight(15),
          left: MySize.getWidth(10),
          right: MySize.getWidth(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: MySize.getHeight(35),
                  height: MySize.getHeight(35),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(9),
                    child: Image.asset(
                      ImageConstant.notification,
                      color: ColorConstants.primaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: MySize.getWidth(10)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stay in the Loop",
                      style: TextStyle(
                        fontSize: MySize.getHeight(15),
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MySize.getHeight(5)),
                    Text(
                      "Get notified about special offers and new \nfeatures. you can always change this later.",
                      style: TextStyle(
                        fontSize: MySize.getHeight(12),
                        height: 1.2,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: MySize.getHeight(20)),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.StayLoopList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.all(MySize.getHeight(13)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(
                        controller.StayLoopList[index].color!,
                      ).withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(
                          controller.StayLoopList[index].color!,
                        ).withValues(alpha: 0.1),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: MySize.getHeight(30),
                        height: MySize.getHeight(30),
                        decoration: BoxDecoration(
                          color: Color(
                            controller.StayLoopList[index].color!,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Image.asset(
                            controller.StayLoopList[index].textIcon ?? "",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(width: MySize.getWidth(10)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.StayLoopList[index].label ?? "",
                            style: TextStyle(
                              fontSize: MySize.getHeight(13),
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            controller.StayLoopList[index].subLabel ?? "",
                            style: TextStyle(
                              fontSize: MySize.getHeight(9),
                              height: 1.2,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: MySize.getHeight(13));
              },
            ),
            Spacer(),
            InkWell(
              onTap: () async {
                box.write(ArgumentConstant.start, true);
                await NotificationService.instance.init();
                await NotificationService.instance.scheduleDailyNotifications();
                Get.offAllNamed(Routes.MAIN_HOME);
              },
              child: Container(
                width: double.infinity,
                height: MySize.getHeight(40),
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    "Enable Notifications",
                    style: TextStyle(
                      fontSize: MySize.getHeight(13),
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MySize.getHeight(30)),
          ],
        ),
      ),
    );
  }
}
