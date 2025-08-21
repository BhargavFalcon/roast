import 'package:get/get.dart';
import 'package:roast/app/constants/image_constants.dart';
import 'package:roast/app/model/selectorModel.dart';

class StayLoopController extends GetxController {
  RxList<Selector> StayLoopList =
      <Selector>[
        Selector(
          label: "Special Offers",
          subLabel: "Get notified about exclusive deals and premium features",
          textIcon: ImageConstant.offers,
          color: 0xFFFFC105,
        ),
        Selector(
          label: "New Features",
          subLabel:
              "Be the first to know about new roasting styles and updates",
          textIcon: ImageConstant.features,
          color: 0xFFEF6356,
        ),
        Selector(
          label: "Roast Reminders",
          subLabel:
              "Never miss a chance to roast your friends with gentle \nreminders",
          textIcon: ImageConstant.fill_medium,
          color: 0xFFFF5C00,
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
