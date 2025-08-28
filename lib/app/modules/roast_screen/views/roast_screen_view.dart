import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/color_constant.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/constants/subscriptionService.dart';
import 'package:roast/main.dart';

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
          body: Obx(
            () => Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  SizedBox(height: MySize.getHeight(10)),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: [
                            _buildPhotoSelectionCard(context),
                            SizedBox(height: MySize.getHeight(10)),
                            _buildBurnLevelCard(),
                            SizedBox(height: MySize.getHeight(10)),
                            _buildPoisonSelectionCard(),
                            SizedBox(height: MySize.getHeight(10)),
                            _buildTargetSelectionCard(),
                            SizedBox(height: MySize.getHeight(10)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(top: 5, right: 10, left: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildInstructions(),
                SizedBox(height: MySize.getHeight(5)),
                _buildRoastButton(),
                SizedBox(height: MySize.getHeight(10)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
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
          InkWell(
            onTap: () async {
              await SubscriptionService().presentPaywall();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstants.primaryColor.withValues(alpha: 0.3),
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
                    box.read(ArgumentConstant.roastCoin).toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MySize.getHeight(13),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSelectionCard(BuildContext context) {
    return _buildCard(
      icon: ImageConstant.select,
      title: "Select a Photo",
      subtitle: "Choose from gallery or take a new photo",
      child:
          controller.imageFile.value != null
              ? _buildImagePreview(context)
              : _buildPhotoOptions(context),
    );
  }

  Widget _buildBurnLevelCard() {
    return _buildCard(
      icon: ImageConstant.fill_medium,
      title: "Burn Level",
      subtitle: "Choose your roast intensity level",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                controller.burnLevelList.map((burn) {
                  bool isSelected = burn.isSelected.value;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _selectBurnLevel(burn),
                      child: _buildSelectionItem(
                        icon: Image.asset(
                          isSelected ? burn.selectedIcon : burn.unselectedIcon,
                          height: MySize.getHeight(18),
                          color:
                              isSelected
                                  ? ColorConstants.primaryColor
                                  : ColorConstants.primaryColor.withValues(
                                    alpha: 0.5,
                                  ),
                        ),
                        label: burn.label.capitalizeFirst ?? "",
                        isSelected: isSelected,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPoisonSelectionCard() {
    return _buildCard(
      icon: ImageConstant.drama,
      title: "Pick Your Poison",
      subtitle:
          "Pick your roast style to match your vibe.The \nmore unhinged, the better",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                controller.PickPoisonList.map((poison) {
                  bool isSelected = poison.isSelected.value;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        poison.isSelected.value = !poison.isSelected.value;
                        box.write(
                          ArgumentConstant.poison,
                          controller.PickPoisonList.map(
                            (e) => e.toJson(),
                          ).toList(),
                        );
                      },

                      child: _buildSelectionItem(
                        icon: Text(
                          poison.textIcon ?? "",
                          style: TextStyle(fontSize: MySize.getHeight(18)),
                        ),
                        label: poison.label ?? "",
                        isSelected: isSelected,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetSelectionCard() {
    return _buildCard(
      icon: ImageConstant.target,
      title: "Choose Your Targets",
      subtitle:
          "What should we roast? The more you pick, the \nmore brutal the result.",
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:
                controller.ChooseTargetList.map((target) {
                  bool isSelected = target.isSelected.value;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        target.isSelected.value = !target.isSelected.value;
                        box.write(
                          ArgumentConstant.target,
                          controller.ChooseTargetList.map(
                            (e) => e.toJson(),
                          ).toList(),
                        );
                      },
                      child: _buildSelectionItem(
                        icon: Text(
                          target.textIcon ?? "",
                          style: TextStyle(fontSize: MySize.getHeight(18)),
                        ),
                        label: target.label ?? "",
                        isSelected: isSelected,
                        fontSize: MySize.getHeight(8),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String icon,
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: ColorConstants.primaryColor.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstants.primaryColor.withValues(alpha: 0.2),
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
                  width: MySize.getHeight(title == "Select a Photo" ? 35 : 30),
                  height: MySize.getHeight(title == "Select a Photo" ? 35 : 30),
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Image.asset(
                      icon,
                      color: ColorConstants.primaryColor,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(width: MySize.getWidth(10)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: MySize.getHeight(
                            title == "Select a Photo" ? 15 : 14,
                          ),
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 0.9,
                        ),
                      ),
                      SizedBox(height: MySize.getHeight(5)),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: MySize.getHeight(10),
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MySize.getHeight(10)),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionItem({
    required Widget icon,
    required String label,
    required bool isSelected,
    double? fontSize,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: label.length > 10 ? 10 : 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: ColorConstants.primaryColor.withValues(alpha: 0.2),
                    blurRadius: 4,
                    spreadRadius: 3,
                  ),
                ]
                : [],
        border: Border.all(
          color:
              isSelected
                  ? ColorConstants.primaryColor
                  : ColorConstants.primaryColor.withValues(alpha: 0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? MySize.getHeight(10),
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Obx(() {
      if (controller.imageFile.value == null) {
        return const SizedBox(); // no image
      }

      return Container(
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
                gaplessPlayback: true, // avoid flicker on rebuild
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () => controller.imageFile.value = null,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: ColorConstants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.close, size: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildPhotoOptions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => handleGallerySelection(context),
            child: _buildPhotoOptionCard(
              title: "Gallery",
              image: ImageConstant.gallery,
              gradient: const [Color(0xFF4A90E2), Color(0xFFD54ADF)],
              borderColor: const Color(0xFF4A90E2),
            ),
          ),
        ),
        SizedBox(width: MySize.getWidth(15)),
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () => handleCameraSelection(context),
            child: _buildPhotoOptionCard(
              title: "Camera",
              image: ImageConstant.camera,
              gradient: const [Color(0xFFFF7E38), Color(0xFFFF3C3C)],
              borderColor: const Color(0xFFFF7E38),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoOptionCard({
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

  Widget _buildInstructions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.arrow_upward, size: 15, color: ColorConstants.primaryColor),
        SizedBox(width: MySize.getWidth(5)),
        Text(
          "Select a photo to start roasting",
          style: TextStyle(
            fontSize: MySize.getHeight(10),
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildRoastButton() {
    return InkWell(
      onTap: _handleRoastButtonTap,
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
    );
  }

  void _selectBurnLevel(burn) {
    for (var item in controller.burnLevelList) {
      item.isSelected.value = false;
    }
    burn.isSelected.value = true;
  }

  Future<void> handleCameraSelection(BuildContext context) async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        controller.setImage(context, File(file.path));
      }
    } else if (status.isPermanentlyDenied) {
      _showCameraPermissionDialog();
    }
  }

  Future<void> handleGallerySelection(BuildContext context) async {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      controller.setImage(context, File(file.path));
    }
  }

  void _handleRoastButtonTap() async {
    if (controller.imageFile.value == null) {
      showCommonDialog(
        title: 'Oops!',
        message:
            "Please select an image to roast. You can choose from the gallery or take a new photo.",
      );
      return;
    }

    if (box.read(ArgumentConstant.roastCoin) <= 0 &&
        !(await SubscriptionService.hasActiveSubscription())) {
      await SubscriptionService().presentPaywall();
      return;
    }

    await controller.resizeImage(controller.imageFile.value!).then((value) {
      if (!isNullEmptyOrFalse(value)) {
        String selectedBurn =
            controller.burnLevelList
                .firstWhere((burn) => burn.isSelected.value)
                .label;

        List<String> style =
            controller.PickPoisonList.where(
              (poison) => poison.isSelected.value,
            ).map((e) => e.label!.toLowerCase()).toList();

        List<String> target =
            controller.ChooseTargetList.where(
              (poison) => poison.isSelected.value,
            ).map((e) => e.label!.toLowerCase()).toList();
        controller.roastImageApi(
          context: Get.context!,
          style: style,
          target: target,
          intensity: selectedBurn,
          imageBytes: value,
        );
      }
    });
  }

  void _showCameraPermissionDialog() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCupertinoDialog(
        context: Get.context!,
        builder:
            (BuildContext dialogContext) => CupertinoAlertDialog(
              title: const Text(
                'Camera Access Needed',
                style: TextStyle(
                  color: CupertinoColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: const Text(
                "To roast photos using your device's camera, we need access to the camera. Please grant camera access in Settings",
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: CupertinoColors.destructiveRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    openAppSettings();
                  },
                  child: Text(
                    'Open Settings',
                    style: TextStyle(color: ColorConstants.primaryColor),
                  ),
                ),
              ],
            ),
      );
    });
  }
}
