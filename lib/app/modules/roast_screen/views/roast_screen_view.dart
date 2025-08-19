import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';

import '../controllers/roast_screen_controller.dart';

class RoastScreenView extends GetView<RoastScreenController> {
  const RoastScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoastScreenController>(
      init: RoastScreenController(),
      assignId: true,
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 15,
              left: 15,
              right: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Roast App",
                      style: TextStyle(
                        fontSize: MySize.getHeight(20),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                            height: MySize.getHeight(18),
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
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
                SizedBox(height: MySize.getHeight(20)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: ColorConstants.primaryColor.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstants.primaryColor.withValues(
                          alpha: 0.2,
                        ),
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: MySize.getHeight(35),
                              height: MySize.getHeight(35),
                              decoration: BoxDecoration(
                                color: ColorConstants.primaryColor.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(9),
                                child: Image.asset(
                                  ImageConstant.select,
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
                                  "Select a Photo",
                                  style: TextStyle(
                                    fontSize: MySize.getHeight(14),
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: MySize.getHeight(5)),
                                Text(
                                  "Choose a from gallery or take a new photo",
                                  style: TextStyle(
                                    fontSize: MySize.getHeight(10),
                                    height: 1,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: MySize.getHeight(20)),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: MySize.getHeight(150),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(
                                      0xFF4A90E2,
                                    ).withValues(alpha: 0.4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(
                                        0xFF4A90E2,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                              0xFF4A90E2,
                                            ).withValues(alpha: 0.6),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF4A90E2), // Blue
                                            Color(0xFFD54ADF), // Pink-Purple
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        ImageConstant.gallery,
                                        height: MySize.getHeight(15),
                                      ),
                                    ),
                                    SizedBox(height: MySize.getHeight(10)),
                                    Center(
                                      child: Text(
                                        "Gallery",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MySize.getHeight(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: MySize.getWidth(15)),
                            Expanded(
                              child: Container(
                                height: MySize.getHeight(150),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(
                                      0xFFFF7E38,
                                    ).withValues(alpha: 0.4),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(
                                        0xFFFF7E38,
                                      ).withValues(alpha: 0.3),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(
                                              0xFFFF7E38,
                                            ).withValues(alpha: 0.6),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFFFF7E38),
                                            Color(0xFFFF3C3C),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        ImageConstant.camera,
                                        height: MySize.getHeight(15),
                                      ),
                                    ),
                                    SizedBox(height: MySize.getHeight(10)),
                                    Center(
                                      child: Text(
                                        "Camera",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: MySize.getHeight(12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
