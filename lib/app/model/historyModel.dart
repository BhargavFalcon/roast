import 'dart:convert';
import 'dart:typed_data';

class HistoryModel {
  Uint8List imageBytes;
  List<String> roastList;
  DateTime dateTime;

  HistoryModel({
    required this.imageBytes,
    required this.roastList,
    required this.dateTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      imageBytes: base64Decode(json['imageBytes']),
      roastList: List<String>.from(json['roastList'] ?? []),
      dateTime: DateTime.parse(json['dateTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imageBytes': base64Encode(imageBytes),
      'roastList': roastList,
      'dateTime': dateTime.toIso8601String(),
    };
  }
}
