import 'package:get/get.dart';
import 'package:roast/app/model/selectorModel.dart';

class ChooseYourTargetsController extends GetxController {
  RxList<Selector> ChooseTargetList =
      <Selector>[
        Selector(
          label: "Looks & appearance",
          subLabel: "Facial features, expressions, and overall appearance",
          textIcon: "😬",
          isSelected: false,
        ),
        Selector(
          label: "Fashion & style",
          subLabel: "Outfit choices, fashion sense, and styling decisions",
          textIcon: "👕",
          isSelected: false,
        ),
        Selector(
          label: "Background & setting",
          subLabel: "Room setup, background mess, and environment",
          textIcon: "🏠",
          isSelected: false,
        ),
        Selector(
          label: "Chat conversations",
          subLabel: "Texting style, conversation skills, and message content",
          textIcon: "💬",
          isSelected: false,
        ),
      ].obs;
  @override
  void onInit() {
    super.onInit();
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
