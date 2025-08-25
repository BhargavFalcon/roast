import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/model/historyModel.dart';
import 'package:roast/app/routes/app_pages.dart';

import '../../../../main.dart';

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
    final decodedImage = await decodeImageFromList(
      await imageFile.readAsBytes(),
    );
    int origWidth = decodedImage.width;
    int origHeight = decodedImage.height;

    const int targetSize = 384;
    double aspectRatio = origWidth / origHeight;
    int newWidth, newHeight;

    if (origWidth >= origHeight) {
      newWidth = targetSize;
      newHeight = (targetSize / aspectRatio).round();
    } else {
      newHeight = targetSize;
      newWidth = (targetSize * aspectRatio).round();
    }

    final compressed = await FlutterImageCompress.compressWithFile(
      imageFile.absolute.path,
      minWidth: newWidth,
      minHeight: newHeight,
      quality: 40,
      format: CompressFormat.jpeg,
    );
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
      "Authorization": "Bearer ",
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
        .then((response) async {
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
            Uint8List uint8list = await fileToUint8List(imageFile.value!);
            RxList<HistoryModel> historyList = <HistoryModel>[].obs;
            final rawList = box.read(ArgumentConstant.historyList);
            if (!isNullEmptyOrFalse(rawList)) {
              historyList.value =
                  List<HistoryModel>.from(
                    rawList.map((item) => HistoryModel.fromJson(item)),
                  ).toList();
            } else {
              historyList.value = [];
            }
            HistoryModel historyModel = HistoryModel(
              imageBytes: uint8list,
              roastList: roastList,
              dateTime: DateTime.now(),
            );
            historyList.add(historyModel);
            box.write(
              ArgumentConstant.historyList,
              historyList.map((item) => item.toJson()).toList(),
            );
            Get.toNamed(
              Routes.ROAST_PREVIEW_SCREEN,
              arguments: {
                ArgumentConstant.imageFile: uint8list,
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

  Future<Uint8List> fileToUint8List(File imageFile) async {
    Uint8List bytes = await imageFile.readAsBytes();
    return bytes;
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
