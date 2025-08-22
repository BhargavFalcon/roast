import 'dart:ui';

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
          InkWell(
            onTap: () {
              shareRoast(context: context);
            },
            child: Image.asset(
              ImageConstant.share,
              height: 24,
              color: ColorConstants.primaryColor,
            ),
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
                                fontSize: MySize.getHeight(13),
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

  Future shareRoast({required BuildContext context}) {
    int currentIndex = 0;

    return showGeneralDialog(
      context: context,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 0),
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(controller.imageFile.value!, fit: BoxFit.cover),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                  ),
                  Positioned.fill(
                    child: ZoomableMovable(
                      child: Image.file(
                        controller.imageFile.value!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  ZoomableMovable(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 280),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.red.withValues(alpha: 0.3),
                                width: 1.2,
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  child: Text(
                                    controller.roastList[currentIndex],
                                    key: ValueKey(currentIndex),
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Divider(
                                  color: Colors.red.withValues(alpha: 0.3),
                                  thickness: 1,
                                  height: 10,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap:
                                          currentIndex > 0
                                              ? () =>
                                                  setState(() => currentIndex--)
                                              : null,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color:
                                              currentIndex > 0
                                                  ? ColorConstants.primaryColor
                                                      .withValues(alpha: 0.3)
                                                  : Colors.grey.withValues(
                                                    alpha: 0.3,
                                                  ),
                                          border: Border.all(
                                            color:
                                                currentIndex > 0
                                                    ? ColorConstants
                                                        .primaryColor
                                                        .withValues(alpha: 0.3)
                                                    : Colors.grey.withValues(
                                                      alpha: 0.3,
                                                    ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_ios_new_rounded,
                                          size: 14,
                                          color:
                                              currentIndex > 0
                                                  ? ColorConstants.primaryColor
                                                  : Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '🔥 Roast Me ',
                                      style: TextStyle(
                                        color: ColorConstants.primaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap:
                                          currentIndex <
                                                  controller.roastList.length -
                                                      1
                                              ? () =>
                                                  setState(() => currentIndex++)
                                              : null,
                                      child: Container(
                                        padding: const EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          color:
                                              currentIndex <
                                                      controller
                                                              .roastList
                                                              .length -
                                                          1
                                                  ? ColorConstants.primaryColor
                                                      .withValues(alpha: 0.3)
                                                  : Colors.grey.withValues(
                                                    alpha: 0.3,
                                                  ),
                                          border: Border.all(
                                            color:
                                                currentIndex <
                                                        controller
                                                                .roastList
                                                                .length -
                                                            1
                                                    ? ColorConstants
                                                        .primaryColor
                                                        .withValues(alpha: 0.3)
                                                    : Colors.grey.withValues(
                                                      alpha: 0.3,
                                                    ),
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 14,
                                          color:
                                              currentIndex <
                                                      controller
                                                              .roastList
                                                              .length -
                                                          1
                                                  ? ColorConstants.primaryColor
                                                  : Colors.grey,
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
                  Positioned(
                    top: 50,
                    right: 20,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 50,
                    child: InkWell(
                      onTap: () => Get.back(),
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ColorConstants.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Share Roast",
                              style: TextStyle(
                                fontSize: MySize.getHeight(13),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class ZoomableMovable extends StatefulWidget {
  final Widget child;
  final bool enableGestures;

  const ZoomableMovable({
    super.key,
    required this.child,
    this.enableGestures = true,
  });

  @override
  State<ZoomableMovable> createState() => _ZoomableMovableState();
}

class _ZoomableMovableState extends State<ZoomableMovable> {
  double scale = 1.0;
  double previousScale = 1.0;
  Offset position = Offset.zero;
  Offset previousPosition = Offset.zero;
  bool isScaling = false;

  @override
  Widget build(BuildContext context) {
    if (!widget.enableGestures) {
      return widget.child;
    }

    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onScaleStart: (details) {
        previousScale = scale;
        previousPosition = details.focalPoint - position;
        isScaling = details.pointerCount > 1;
      },
      onScaleUpdate: (details) {
        setState(() {
          if (details.pointerCount > 1) {
            // Multi-finger gesture - handle zoom and pan
            scale = (previousScale * details.scale).clamp(0.5, 3.0);
            position = details.focalPoint - previousPosition;
          } else {
            // Single finger - only pan
            position = details.focalPoint - previousPosition;
          }
        });
      },
      onScaleEnd: (details) {
        isScaling = false;
      },
      child: Transform(
        transform:
            Matrix4.identity()
              ..translate(position.dx, position.dy)
              ..scale(scale),
        alignment: Alignment.center,
        child: widget.child,
      ),
    );
  }
}
