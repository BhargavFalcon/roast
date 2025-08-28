import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class MySize {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late bool isMini;
  static double? safeWidth;
  static double? safeHeight;

  static late double scaleFactorWidth;
  static late double scaleFactorHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth =
        (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android)
            ? _mediaQueryData.size.width
            : 390;
    screenHeight =
        (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android)
            ? _mediaQueryData.size.height
            : _mediaQueryData.size.height;
    isMini = _mediaQueryData.size.height < 700;
    double safeAreaWidth =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    double safeAreaHeight =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeWidth = (screenWidth - safeAreaWidth);
    safeHeight = (screenHeight - safeAreaHeight);

    safeWidth = (screenWidth - safeAreaWidth);
    safeHeight = (screenHeight - safeAreaHeight);

    scaleFactorHeight = (safeHeight! / 748);
    if (scaleFactorHeight < 1) {
      double diff = (1 - scaleFactorHeight) * (1 - scaleFactorHeight);
      scaleFactorHeight += diff;
    }

    scaleFactorWidth = (safeWidth! / 360);

    if (scaleFactorWidth < 1) {
      double diff = (1 - scaleFactorWidth) * (1 - scaleFactorWidth);
      scaleFactorWidth += diff;
    }
  }

  static double getWidth(double size) {
    return (size * scaleFactorWidth);
  }

  static double getHeight(double size) {
    return (size * scaleFactorHeight);
  }
}

extension Spacing on () {
  static EdgeInsetsGeometry zero = EdgeInsets.zero;

  static EdgeInsetsGeometry only({
    double top = 0,
    double right = 0,
    double bottom = 0,
    double left = 0,
  }) {
    return EdgeInsets.only(left: left, right: right, top: top, bottom: bottom);
  }

  static EdgeInsetsGeometry fromLTRB(
    double left,
    double top,
    double right,
    double bottom,
  ) {
    return Spacing.only(bottom: bottom, top: top, right: right, left: left);
  }

  static EdgeInsetsGeometry all(double spacing) {
    return Spacing.only(
      bottom: spacing,
      top: spacing,
      right: spacing,
      left: spacing,
    );
  }

  static EdgeInsetsGeometry left(double spacing) {
    return Spacing.only(left: spacing);
  }

  static EdgeInsetsGeometry nLeft(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing, right: spacing);
  }

  static EdgeInsetsGeometry top(double spacing) {
    return Spacing.only(top: spacing);
  }

  static EdgeInsetsGeometry nTop(double spacing) {
    return Spacing.only(left: spacing, bottom: spacing, right: spacing);
  }

  static EdgeInsetsGeometry right(double spacing) {
    return Spacing.only(right: spacing);
  }

  static EdgeInsetsGeometry nRight(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing, left: spacing);
  }

  static EdgeInsetsGeometry bottom(double spacing) {
    return Spacing.only(bottom: spacing);
  }

  static EdgeInsetsGeometry nBottom(double spacing) {
    return Spacing.only(top: spacing, left: spacing, right: spacing);
  }

  static EdgeInsetsGeometry horizontal(double spacing) {
    return Spacing.only(left: spacing, right: spacing);
  }

  static x(double spacing) {
    return Spacing.only(left: spacing, right: spacing);
  }

  static xy(double xSpacing, double ySpacing) {
    return Spacing.only(
      left: xSpacing,
      right: xSpacing,
      top: ySpacing,
      bottom: ySpacing,
    );
  }

  static y(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing);
  }

  static EdgeInsetsGeometry vertical(double spacing) {
    return Spacing.only(top: spacing, bottom: spacing);
  }

  static EdgeInsetsGeometry symmetric({
    double vertical = 0,
    double horizontal = 0,
  }) {
    return Spacing.only(
      top: vertical,
      right: horizontal,
      left: horizontal,
      bottom: vertical,
    );
  }

  static Widget height(double height) {
    return SizedBox(height: MySize.getHeight(height));
  }

  static Widget width(double width) {
    return SizedBox(width: MySize.getWidth(width));
  }
}

class Space {
  Space();

  static Widget height(double space) {
    return SizedBox(height: MySize.getHeight(space));
  }

  static Widget width(double space) {
    return SizedBox(width: MySize.getHeight(space));
  }
}

enum ShapeTypeFor { container, button }

class Shape {
  static dynamic circular(
    double radius, {
    ShapeTypeFor shapeTypeFor = ShapeTypeFor.container,
  }) {
    BorderRadius borderRadius = BorderRadius.all(
      Radius.circular(MySize.getHeight(radius)),
    );

    switch (shapeTypeFor) {
      case ShapeTypeFor.container:
        return borderRadius;
      case ShapeTypeFor.button:
        return RoundedRectangleBorder(borderRadius: borderRadius);
    }
  }

  static dynamic circularTop(
    double radius, {
    ShapeTypeFor shapeTypeFor = ShapeTypeFor.container,
  }) {
    BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(MySize.getHeight(radius)),
      topRight: Radius.circular(MySize.getHeight(radius)),
    );
    switch (shapeTypeFor) {
      case ShapeTypeFor.container:
        return borderRadius;

      case ShapeTypeFor.button:
        return RoundedRectangleBorder(borderRadius: borderRadius);
    }
  }
}

bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o || "null" == o;
}

bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  return emailRegex.hasMatch(email);
}

CachedNetworkImage getImageByLink({
  required String url,
  required double height,
  required double width,
  bool isLoading = false,
  bool colorFilter = false,
  String imagePlaceHolder = "",
  BoxFit boxFit = BoxFit.cover,
  Widget? image,
  BorderRadiusGeometry? borderRadius,
  Color? errorColor,
  Color borderColor = Colors.transparent,
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder:
        (context, imageProvider) => Container(
          height: MySize.getHeight(height),
          width: MySize.getHeight(width),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
              colorFilter:
                  (colorFilter)
                      ? ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.6),
                        BlendMode.darken,
                      )
                      : null,
            ),
            borderRadius: borderRadius ?? BorderRadius.circular(0),
          ),
        ),
    errorListener: (value) {
      if (kDebugMode) {
        print("Error: $value");
      }
    },
    placeholder:
        (context, url) =>
            (isLoading)
                ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: borderRadius ?? BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.circular(0),
                    child:
                        image ??
                        Image(
                          image: AssetImage(imagePlaceHolder),
                          height: MySize.getHeight(height),
                          width: MySize.getHeight(width),
                          fit: BoxFit.cover,
                          color: errorColor,
                        ),
                  ),
                )
                : Container(
                  height: MySize.getHeight(height),
                  width: MySize.getHeight(width),
                  decoration: BoxDecoration(
                    borderRadius: borderRadius ?? BorderRadius.circular(0),
                  ),
                  child: ClipRRect(
                    borderRadius: borderRadius ?? BorderRadius.circular(0),
                    child: LinearProgressIndicator(
                      color: Colors.grey.shade200,
                      backgroundColor: Colors.grey.shade100,
                    ),
                  ),
                ),
    errorWidget:
        (context, url, error) => Container(
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: borderRadius ?? BorderRadius.circular(0),
          ),
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.circular(0),
            child:
                image ??
                Image(
                  image: AssetImage(imagePlaceHolder),
                  height: MySize.getHeight(height),
                  width: MySize.getHeight(width),
                  fit: BoxFit.cover,
                  color: errorColor,
                ),
          ),
        ),
  );
}

getSnackBar({
  required BuildContext context,
  String text = "",
  double size = 16,
  int duration = 500,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: TextStyle(fontSize: MySize.getHeight(size))),
      duration: Duration(milliseconds: duration),
    ),
  );
}

void showDarkCupertinoErrorDialog(
  BuildContext context,
  String message, {
  String ButtonText = "OK",
  String? closeButtonText,
  String title = "Error",
  void Function()? onPressed,
}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoTheme(
        data: const CupertinoThemeData(
          brightness: Brightness.dark,
          primaryColor: CupertinoColors.systemRed,
        ),
        child: CupertinoAlertDialog(
          title: Text(
            title,
            style: const TextStyle(color: CupertinoColors.white),
          ),
          content: Text(
            message,
            style: const TextStyle(color: CupertinoColors.systemGrey2),
          ),
          actions: [
            if (closeButtonText != null)
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  closeButtonText,
                  style: const TextStyle(color: CupertinoColors.destructiveRed),
                ),
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                if (onPressed != null) {
                  onPressed();
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text(
                ButtonText,
                style: const TextStyle(color: CupertinoColors.activeBlue),
              ),
            ),
          ],
        ),
      );
    },
  );
}

class FireLoader {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      useSafeArea: false,
      builder: (context) {
        return SizedBox.expand(
          child: Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(color: Colors.white.withValues(alpha: 0.5)),
              ),
              Center(
                child: SizedBox(
                  height: 200,
                  child: Lottie.asset(
                    'assets/Fire_animation.json',
                    fit: BoxFit.contain,
                    repeat: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

urlLauncher({required Uri url, String name = "", String? error}) async {
  try {
    if (!await launchUrl(url, mode: LaunchMode.externalNonBrowserApplication)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  } catch (e) {
    print(e);
    showCommonDialog(
      title: "Error",
      message: error ?? "Unable to find $name in your device",
    );
  }
}

void showCommonDialog({
  required String title,
  required String message,
  String buttonText = "OK",
  VoidCallback? onPressed,
}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showCupertinoDialog(
      context: Get.context!,
      builder:
          (BuildContext dialogContext) => CupertinoAlertDialog(
            title: Text(
              title,
              style: const TextStyle(
                color: CupertinoColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(message, style: const TextStyle(color: Colors.black)),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                  if (onPressed != null) onPressed();
                },
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color:
                        Colors
                            .blue, // yaha apka ColorConstants.primaryColor laga do
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );
  });
}
