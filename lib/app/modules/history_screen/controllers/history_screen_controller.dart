import 'package:get/get.dart';
import 'package:roast/app/model/historyModel.dart';

import '../../../../main.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/sizeConstant.dart';

class HistoryScreenController extends GetxController {
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  @override
  void onInit() {
    final rawList = box.read(ArgumentConstant.historyList) ?? [];

    if (!isNullEmptyOrFalse(rawList)) {
      historyList.value = List<HistoryModel>.from(
        (rawList as List).map((item) => HistoryModel.fromJson(item)),
      );
    } else {
      historyList.clear();
    }

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
