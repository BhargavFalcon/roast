import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:roast/app/model/historyModel.dart';

import '../../../../main.dart';
import '../../../constants/api_constants.dart';
import '../../../constants/sizeConstant.dart';

class HistoryScreenController extends GetxController {
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;
  RxMap<String, List<HistoryModel>> groupedHistory =
      <String, List<HistoryModel>>{}.obs;

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
    groupByDate();
    super.onInit();
  }

  void groupByDate() {
    Map<String, List<HistoryModel>> grouped = {};
    for (var history in historyList) {
      String dateKey = DateFormat('yyyy-MM-dd').format(history.dateTime);
      grouped.putIfAbsent(dateKey, () => []);
      grouped[dateKey]!.add(history);
    }
    grouped.forEach((key, value) {
      value.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    });
    final sortedKeys =
        grouped.keys.toList()
          ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
    groupedHistory.value = {for (var key in sortedKeys) key: grouped[key]!};
  }
}
