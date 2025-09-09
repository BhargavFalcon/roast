import 'dart:convert';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/constants/sizeConstant.dart';
import 'package:roast/app/model/historyModel.dart';
import 'package:roast/app/model/selectorModel.dart';
import 'package:roast/app/routes/app_pages.dart';

import '../../../../main.dart';

class RoastScreenController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);
  final RxList<BurnModel> burnLevelList =
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

  final RxList<Selector> PickPoisonList =
      <Selector>[
        Selector(label: "Dark", textIcon: "🖤", isSelected: false),
        Selector(label: "Fun", textIcon: "🎉", isSelected: false),
        Selector(label: "Savage", textIcon: "😈", isSelected: false),
        Selector(label: "Cringe", textIcon: "😬", isSelected: false),
      ].obs;

  final RxList<Selector> ChooseTargetList =
      <Selector>[
        Selector(
          label: "Looks & appearance",
          textIcon: "😬",
          isSelected: false,
        ),
        Selector(label: "Fashion & style", textIcon: "👕", isSelected: false),
        Selector(
          label: "Background & setting",
          textIcon: "🏠",
          isSelected: false,
        ),
        Selector(
          label: "Chat conversations",
          textIcon: "💬",
          isSelected: false,
        ),
      ].obs;

  static const int _targetImageSize = 384;
  static const int _imageQuality = 30;
  static const int _maxTokens = 200;

  @override
  void onInit() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final poisonList = box.read(ArgumentConstant.poison) ?? [];
      if (!isNullEmptyOrFalse(poisonList)) {
        PickPoisonList.value = List<Selector>.from(
          (poisonList as List).map((item) => Selector.fromJson(item)),
        );
      }
      final targetList = box.read(ArgumentConstant.target) ?? [];
      if (!isNullEmptyOrFalse(targetList)) {
        ChooseTargetList.value = List<Selector>.from(
          (targetList as List).map((item) => Selector.fromJson(item)),
        );
      }
    });
    super.onInit();
  }

  Future<void> setImage(BuildContext context, File file) async {
    imageFile.value = file;

    await precacheImage(FileImage(file), context);
  }

  Future<Uint8List> resizeImage(File imageFile) async {
    try {
      final decodedImage = await decodeImageFromList(
        await imageFile.readAsBytes(),
      );
      final dimensions = _calculateNewDimensions(
        decodedImage.width,
        decodedImage.height,
      );

      final compressed = await FlutterImageCompress.compressWithFile(
        imageFile.absolute.path,
        minWidth: dimensions.width,
        minHeight: dimensions.height,
        quality: _imageQuality,
        format: CompressFormat.jpeg,
      );

      return compressed ?? await imageFile.readAsBytes();
    } catch (e) {
      print("Error resizing image: $e");
      return await imageFile.readAsBytes();
    }
  }

  ImageDimensions _calculateNewDimensions(
    int originalWidth,
    int originalHeight,
  ) {
    double aspectRatio = originalWidth / originalHeight;
    int newWidth, newHeight;

    if (originalWidth >= originalHeight) {
      newWidth = _targetImageSize;
      newHeight = (_targetImageSize / aspectRatio).round();
    } else {
      newHeight = _targetImageSize;
      newWidth = (_targetImageSize * aspectRatio).round();
    }

    return ImageDimensions(width: newWidth, height: newHeight);
  }

  Future<void> roastImageApi({
    required BuildContext context,
    required List<String> style,
    required List<String> target,
    required String intensity,
    Uint8List? imageBytes,
  }) async {
    try {
      FireLoader.show(context);

      final response = await _makeApiRequest(
        style,
        target,
        intensity,
        imageBytes,
      );

      if (response.statusCode == 200) {
        if (box.read(ArgumentConstant.roastCoin) > 0) {
          int roastCoin = box.read(ArgumentConstant.roastCoin) ?? 0;
          box.write(ArgumentConstant.roastCoin, roastCoin - 1);
        }
        await _handleSuccessResponse(response);
      } else {
        _handleErrorResponse(response);
      }
    } catch (e) {
      print("Exception in API call: $e");
      showCommonDialog(
        title: 'Oops!',
        message: "Something went wrong. Please try again later.",
      );
    } finally {
      FireLoader.hide(context);
    }
  }

  Future<http.Response> _makeApiRequest(
    List<String> style,
    List<String> target,
    String intensity,
    Uint8List? imageBytes,
  ) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");
    final headers = _buildHeaders();
    final body = _buildRequestBody(style, target, intensity, imageBytes);

    return await http.post(url, headers: headers, body: jsonEncode(body));
  }

  Map<String, String> _buildHeaders() {
    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${dotenv.env['API_KEY']}",
    };
  }

  Map<String, dynamic> _buildRequestBody(
    List<String> style,
    List<String> target,
    String intensity,
    Uint8List? imageBytes,
  ) {
    final content = <Map<String, dynamic>>[
      {
        "type": "text",
        "text":
            "Style: ${style.join(",")}, Target: ${target.join(",")}, Intensity: $intensity.",
      },
    ];

    if (imageBytes != null) {
      final base64Img = base64Encode(imageBytes);
      content.add({
        "type": "image_url",
        "image_url": {"url": "data:image/jpeg;base64,$base64Img"},
      });
    }

    return {
      "model": "gpt-4o-mini",
      "messages": [
        {
          "role": "system",
          "content":
              "You are a comic roast bot. Generate 5 distinct one-liner roasts, max 120 chars each.",
        },
        {"role": "user", "content": content},
      ],
      "max_tokens": _maxTokens,
    };
  }

  Future<void> _handleSuccessResponse(http.Response response) async {
    final data = jsonDecode(response.body);
    print(data);
    final content = data["choices"][0]["message"]["content"];
    final roastList = _parseRoastList(content);

    await _saveToHistory(roastList);

    _navigateToPreview(roastList);
    _resetSelections();
  }

  List<String> _parseRoastList(String content) {
    return content
        .split("\n")
        .where((line) => RegExp(r'^\d+\.\s').hasMatch(line.trim()))
        .map((line) => line.replaceFirst(RegExp(r'^\d+\.\s*'), '').trim())
        .toList();
  }

  Future<void> _saveToHistory(List<String> roastList) async {
    if (imageFile.value == null) return;

    final imageBytes = await fileToUint8List(imageFile.value!);
    final historyList = _getExistingHistory();

    final historyModel = HistoryModel(
      imageBytes: imageBytes,
      roastList: roastList,
      dateTime: DateTime.now(),
    );

    historyList.add(historyModel);
    box.write(
      ArgumentConstant.historyList,
      historyList.map((item) => item.toJson()).toList(),
    );
  }

  RxList<HistoryModel> _getExistingHistory() {
    final rawList = box.read(ArgumentConstant.historyList);
    if (!isNullEmptyOrFalse(rawList)) {
      return List<HistoryModel>.from(
        rawList.map((item) => HistoryModel.fromJson(item)),
      ).toList().obs;
    }
    return <HistoryModel>[].obs;
  }

  void _resetSelections() {
    imageFile.value = null;
    burnLevelList
        .firstWhere((level) => level.isSelected.value)
        .isSelected
        .value = false;
    burnLevelList[0].isSelected.value = true;
  }

  void _navigateToPreview(List<String> roastList) async {
    final imageBytes = await fileToUint8List(imageFile.value!);
    Get.toNamed(
      Routes.ROAST_PREVIEW_SCREEN,
      arguments: {
        ArgumentConstant.imageFile: imageBytes,
        ArgumentConstant.roastList: roastList,
      },
    );
  }

  void _handleErrorResponse(http.Response response) {
    print("API Error: ${response.statusCode} - ${response.body}");
    showCommonDialog(
      title: 'Oops!',
      message: "Something went wrong. Please try again later.",
    );
  }

  Future<Uint8List> fileToUint8List(File imageFile) async {
    return await imageFile.readAsBytes();
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
  final String label;
  final String selectedIcon;
  final String unselectedIcon;
  final RxBool isSelected = false.obs;

  BurnModel({
    required this.label,
    required this.selectedIcon,
    required this.unselectedIcon,
    bool isSelected = false,
  }) {
    this.isSelected.value = isSelected;
  }
}

class ImageDimensions {
  final int width;
  final int height;

  ImageDimensions({required this.width, required this.height});
}
