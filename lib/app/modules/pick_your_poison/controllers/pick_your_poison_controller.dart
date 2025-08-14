import 'package:get/get.dart';
import 'package:roast/app/model/selectorModel.dart';

class PickYourPoisonController extends GetxController {
  RxList<Selector> PickPoisonList =
      <Selector>[
        Selector(
          label: "Dark",
          subLabel: "Twisted humor with psychological warfare vibes",
          textIcon: "🖤",
          isSelected: false,
        ),
        Selector(
          label: "Fun",
          subLabel: "Playful burns that sting but keep you laughing",
          textIcon: "🎉",
          isSelected: false,
        ),
        Selector(
          label: "Savage",
          subLabel: "Absolutely ruthless with zero mercy or chill",
          textIcon: "😈",
          isSelected: false,
        ),
        Selector(
          label: "Cringe",
          subLabel: "Awkwardly uncomfortable roasts that hit different",
          textIcon: "😬",
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
