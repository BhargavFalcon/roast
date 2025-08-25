import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/routes/app_pages.dart';

class RoastScreenController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  RxList<BurnModel> burnLevelList =
      <BurnModel>[
        BurnModel(
          label: "medium",
          selectedIcon: ImageConstant.fill_medium,
          unselectedIcon: ImageConstant.medium,
          isSelected: true,
        ),
        BurnModel(
          label: "high",
          selectedIcon: ImageConstant.fill_high,
          unselectedIcon: ImageConstant.high,
          isSelected: false,
        ),
        BurnModel(
          label: "extreme",
          selectedIcon: ImageConstant.fill_extreme,
          unselectedIcon: ImageConstant.extreme,
          isSelected: false,
        ),
      ].obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<Uint8List> resizeImage(File imageFile) async {
    Uint8List? compressed;
    List<int> qualitySteps = [80, 60, 40, 30, 20, 15, 10];

    for (int q in qualitySteps) {
      compressed = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: 384,
        minHeight: 384,
        quality: q,
        format: CompressFormat.jpeg,
      );

      if (compressed != null && compressed.lengthInBytes / 1024 < 80) {
        break;
      }
    }

    return compressed ?? await imageFile.readAsBytes();
  }

  void roastImageApi({
    required BuildContext context,
    required List<String> style,
    required List<String> target,
    required String intensity,
    Uint8List? imageBytes,
  }) {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${ArgumentConstant.ApiToken}",
    };

    String? base64Img;
    if (imageBytes != null) {
      base64Img = base64Encode(imageBytes);
    }

    final body = {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a comic roast bot. Generate 5 distinct one-liner roasts, max 120 chars each.",
        },
        {
          "role": "user",
          "content": [
            {
              "type": "text",
              "text":
                  "Style: ${style.join(",")}, Target: ${target.join(",")}, Intensity: $intensity.",
            },
            if (base64Img != null)
              {
                "type": "image_url",
                "image_url": {"url": "data:image/jpeg;base64,$base64Img"},
              },
          ],
        },
      ],
      "max_tokens": 200,
    };

    http
        .post(url, headers: headers, body: jsonEncode(body))
        .then((response) {
          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            String content = data["choices"][0]["message"]["content"];
            List<String> roastList =
                content
                    .split("\n")
                    .where((line) => RegExp(r'^\d+\.\s').hasMatch(line.trim()))
                    .map(
                      (line) =>
                          line.replaceFirst(RegExp(r'^\d+\.\s*'), '').trim(),
                    )
                    .toList();
            Get.toNamed(
              Routes.ROAST_PREVIEW_SCREEN,
              arguments: {
                ArgumentConstant.imageFile: imageFile.value,
                ArgumentConstant.roastList: roastList,
              },
            );
          } else {
            print("❌ Error: ${response.statusCode} - ${response.body}");
          }
        })
        .catchError((e) {
          print("⚠️ Exception: $e");
        });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class BurnModel {
  String label;
  String selectedIcon;
  String unselectedIcon;
  RxBool isSelected = false.obs;

  BurnModel({
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
    bool isSelected = false,
  }) {
    this.isSelected.value = isSelected;
  }
}
