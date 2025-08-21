import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/routes/app_pages.dart';

import '../controllers/pick_your_poison_controller.dart';

class PickYourPoisonView extends GetView<PickYourPoisonController> {
  const PickYourPoisonView({super.key});

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
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
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      ImageConstant.drama,
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
                      "Pick Your Poison",
                      style: TextStyle(
                        fontSize: MySize.getHeight(15),
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: MySize.getHeight(5)),
                    Text(
                      "Pick your roast style to match your vibe.The \nmore unhinged, the better.",
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
            SizedBox(height: MySize.getHeight(10)),
            Container(
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: Text(
                  " Mix and match styles for custom brutality ",
                  style: TextStyle(
                    fontSize: MySize.getHeight(10),
                    color: ColorConstants.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: MySize.getHeight(25)),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.PickPoisonList.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Obx(() {
                  bool isSelected =
                      controller.PickPoisonList[index].isSelected.value;
                  return InkWell(
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      controller.PickPoisonList[index].isSelected.value =
                          !isSelected;
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      padding: EdgeInsets.all(MySize.getHeight(13)),
                      transform:
                          Matrix4.identity()..scale(isSelected ? 1.02 : 1.0),
                      transformAlignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color:
                              isSelected
                                  ? ColorConstants.primaryColor.withValues(
                                    alpha: 0.5,
                                  )
                                  : ColorConstants.primaryColor.withValues(
                                    alpha: 0.2,
                                  ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                isSelected
                                    ? ColorConstants.primaryColor.withValues(
                                      alpha: 0.5,
                                    )
                                    : ColorConstants.primaryColor.withValues(
                                      alpha: 0.1,
                                    ),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Text(
                            controller.PickPoisonList[index].textIcon ?? "",
                            style: TextStyle(fontSize: MySize.getHeight(20)),
                          ),
                          SizedBox(width: MySize.getWidth(10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.PickPoisonList[index].label ?? "",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(13),
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                controller.PickPoisonList[index].subLabel ?? "",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(10),
                                  height: 1.2,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          isSelected
                              ? Icon(
                                Icons.check_circle_sharp,
                                color: ColorConstants.primaryColor,
                                size: MySize.getHeight(20),
                              )
                              : Icon(
                                Icons.radio_button_unchecked,
                                color: ColorConstants.primaryColor.withValues(
                                  alpha: 0.5,
                                ),
                                size: MySize.getHeight(20),
                              ),
                        ],
                      ),
                    ),
                  );
                });
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: MySize.getHeight(13));
              },
            ),
            Spacer(),
            Obx(() {
              bool anySelected = controller.PickPoisonList.any(
                (item) => item.isSelected.value,
              );
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,

                  onTap: () {
                    if (anySelected) {
                      Get.offAllNamed(Routes.CHOOSE_YOUR_TARGETS);
                    }
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: double.infinity,
                    transform:
                        Matrix4.identity()..scale(anySelected ? 1.02 : 1.0),
                    transformAlignment: Alignment.center,
                    height: MySize.getHeight(40),
                    decoration: BoxDecoration(
                      color:
                          anySelected
                              ? ColorConstants.primaryColor
                              : ColorConstants.primaryColor.withValues(
                                alpha: 0.5,
                              ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        "Bring It On",
                        style: TextStyle(
                          fontSize: MySize.getHeight(13),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
            SizedBox(height: MySize.getHeight(30)),
          ],
        ),
      ),
    );
  }
}
