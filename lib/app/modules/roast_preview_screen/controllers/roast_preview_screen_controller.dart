import 'dart:io';

import 'package:get/get.dart';
import 'package:roast/app/constants/api_constants.dart';

class RoastPreviewScreenController extends GetxController {
  final Rx<File?> imageFile = Rx<File?>(null);

  RxList<String> roastList =
      <String>[
        "Tera style dekh ke lagta hai fashion industry ne bhi block kar diya hai, Aurat ka dupatta bhi tujhse zyada trend me hai, Aur tu khud ko 'cool' samajhta hai… AC ki hawa bhi tujhe thukra deti hai.",
        "Tere jokes sunke lagta hai comedy ne atma-hatya kar li hai, Meme banane ki koshish mat kar, Tu khud ek walking meme hai.",
        "Teri soch itni shallow hai ki machhli bhi waha doob jaye, Tere words sunke dictionary ko bhi guilt feel hota hai, Aur tu smart banta hai!",
        "Tera chehra dekh ke filter bhi resign de deta hai, Selfie ka naam mat le, Camera ko bhi therapy chahiye tere baad.",
        "Tumhare ideas aur WiFi ka signal – dono hi weak hote hain.",
        "Tum selfie nahi lete, tum logo ko darate ho.",
        "Tumhari speed to government website jaisi hai – bas load hote rehte ho.",
        "Tumhari baatein sunke lagta hai mute button ka invention tumhare liye hi hua tha.",
        "Tum Google bhi search karo to 'Did you mean something better?' aata hai.",
        "Tumhari soch ka level itna low hai ki lift bhi neeche jaane se inkaar kar de.",
      ].obs;

  final RxInt copiedIndex = (-1).obs;

  @override
  void onInit() {
    if (Get.arguments != null &&
        Get.arguments.containsKey(ArgumentConstant.imageFile)) {
      imageFile.value = Get.arguments[ArgumentConstant.imageFile];
    }
    super.onInit();
  }
}
