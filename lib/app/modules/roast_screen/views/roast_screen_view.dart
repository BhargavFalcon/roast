import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
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
          body: Obx(() {
            return Padding(
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
                              height: MySize.getHeight(25),
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
                  SizedBox(height: MySize.getHeight(15)),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ColorConstants.primaryColor.withValues(
                          alpha: 0.3,
                        ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                  padding: const EdgeInsets.all(6),
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
                                      fontSize: MySize.getHeight(15),
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      height: 0.9,
                                    ),
                                  ),
                                  SizedBox(height: MySize.getHeight(5)),
                                  Text(
                                    "Choose from gallery or take a new photo",
                                    style: TextStyle(
                                      fontSize: MySize.getHeight(10),
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MySize.getHeight(20)),
                          controller.imageFile.value != null
                              ? _ImagePreview(context)
                              : Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      onTap: () async {
                                        await _handleCameraSelection();
                                      },
                                      child: _photoOptionCard(
                                        context,
                                        title: "Gallery",
                                        image: ImageConstant.gallery,
                                        gradient: const [
                                          Color(0xFF4A90E2),
                                          Color(0xFFD54ADF),
                                        ],
                                        borderColor: const Color(0xFF4A90E2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: MySize.getWidth(15)),
                                  Expanded(
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      onTap: () async {
                                        await _handleGallerySelection();
                                      },
                                      child: _photoOptionCard(
                                        context,
                                        title: "Camera",
                                        image: ImageConstant.camera,
                                        gradient: const [
                                          Color(0xFFFF7E38),
                                          Color(0xFFFF3C3C),
                                        ],
                                        borderColor: const Color(0xFFFF7E38),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(20)),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: ColorConstants.primaryColor.withValues(
                          alpha: 0.3,
                        ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MySize.getHeight(30),
                                height: MySize.getHeight(30),
                                decoration: BoxDecoration(
                                  color: ColorConstants.primaryColor.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Image.asset(
                                    ImageConstant.fill_medium,
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
                                    "Burn Level",
                                    style: TextStyle(
                                      fontSize: MySize.getHeight(14),
                                      fontWeight: FontWeight.bold,
                                      height: 0.9,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(height: MySize.getHeight(5)),
                                  Text(
                                    "Choose your roast intensity level",
                                    style: TextStyle(
                                      fontSize: MySize.getHeight(10),
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: MySize.getHeight(15)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:
                                controller.burnLevelList.map((burn) {
                                  bool isSelected = burn.isSelected.value;
                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        for (var item
                                            in controller.burnLevelList) {
                                          item.isSelected.value = false;
                                        }
                                        burn.isSelected.value = true;
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              isSelected
                                                  ? ColorConstants.primaryColor
                                                      .withValues(alpha: 0.1)
                                                  : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color:
                                                isSelected
                                                    ? ColorConstants
                                                        .primaryColor
                                                    : ColorConstants
                                                        .primaryColor
                                                        .withValues(alpha: 0.5),
                                            width: 1,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              isSelected
                                                  ? burn.selectedIcon
                                                  : burn.unselectedIcon,
                                              height: MySize.getHeight(18),
                                              color:
                                                  isSelected
                                                      ? ColorConstants
                                                          .primaryColor
                                                      : ColorConstants
                                                          .primaryColor
                                                          .withValues(
                                                            alpha: 0.5,
                                                          ),
                                            ),
                                            Text(
                                              burn.label.capitalizeFirst ?? "",
                                              style: TextStyle(
                                                fontSize: MySize.getHeight(10),
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(15)),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffdcc00).withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Color(0xfffdcc00).withValues(alpha: 0.3),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: MySize.getHeight(30),
                            height: MySize.getHeight(30),
                            decoration: BoxDecoration(
                              color: Color(0xfffdcc00).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Image.asset(
                                ImageConstant.tip,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(width: MySize.getWidth(10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pro Tip",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(14),
                                  fontWeight: FontWeight.bold,
                                  height: 0.9,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: MySize.getHeight(5)),
                              Text(
                                "Upload selfies, group pics, chat screenshots",
                                style: TextStyle(
                                  fontSize: MySize.getHeight(10),
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        size: 15,
                        color: ColorConstants.primaryColor,
                      ),
                      SizedBox(width: MySize.getWidth(5)),
                      Text(
                        "Select a photo to start roasting",
                        style: TextStyle(
                          fontSize: MySize.getHeight(10),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MySize.getHeight(5)),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: MySize.getHeight(40),
                      decoration: BoxDecoration(
                        color: ColorConstants.primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImageConstant.fill_medium,
                              height: MySize.getHeight(18),
                              color: Colors.white,
                            ),
                            SizedBox(width: MySize.getWidth(5)),
                            Text(
                              "Roast Me",
                              style: TextStyle(
                                fontSize: MySize.getHeight(13),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MySize.getHeight(10)),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  Future<void> _handleCameraSelection() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        controller.imageFile.value = File(file.path);
      }
    } else if (status.isPermanentlyDenied) {
      _showCameraPermissionDialog();
    }
  }

  Future<void> _handleGallerySelection() async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      controller.imageFile.value = File(file.path);
    }
  }

  void _showCameraPermissionDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoDialog(
        context: Get.context!,
        builder:
            (BuildContext dialogContext) => CupertinoTheme(
              data: const CupertinoThemeData(
                brightness: Brightness.dark,
                primaryColor: CupertinoColors.white,
                textTheme: CupertinoTextThemeData(
                  textStyle: TextStyle(color: CupertinoColors.white),
                  actionTextStyle: TextStyle(color: CupertinoColors.white),
                ),
              ),
              child: CupertinoAlertDialog(
                title: const Text(
                  'Camera Permission required',
                  style: TextStyle(color: CupertinoColors.white),
                ),
                content: const Text(
                  'Please enable camera access in Settings.',
                  style: TextStyle(color: Colors.white70),
                ),
                actions: [
                  CupertinoDialogAction(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    child: const Text('Cancel'),
                  ),
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      openAppSettings();
                    },
                    child: const Text('Open Settings'),
                  ),
                ],
              ),
            ),
      );
    });
  }

  Widget _ImagePreview(BuildContext context) {
    return Container(
      height: MySize.getHeight(150),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withValues(alpha: 0.3),
            blurRadius: 6,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.file(
              controller.imageFile.value!,
              height: MySize.getHeight(150),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: InkWell(
              onTap: () {
                controller.imageFile.value = null;
              },
              child: Container(
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  color: ColorConstants.primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Icon(Icons.close, size: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _photoOptionCard(
    BuildContext context, {
    required String title,
    required String image,
    required List<Color> gradient,
    required Color borderColor,
  }) {
    return Container(
      height: MySize.getHeight(150),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.3),
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: borderColor.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(image, height: MySize.getHeight(15)),
          ),
          SizedBox(height: MySize.getHeight(12)),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: MySize.getHeight(12),
            ),
          ),
        ],
      ),
    );
  }
}
