import 'package:get/get.dart';

class SelectorModel {
  List<Selector>? selector;

  SelectorModel({this.selector});

  SelectorModel.fromJson(Map<String, dynamic> json) {
    if (json['selector'] != null) {
      selector = <Selector>[];
      json['selector'].forEach((v) {
        selector!.add(new Selector.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.selector != null) {
      data['selector'] = this.selector!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Selector {
  String? label;
  String? subLabel;
  String? textIcon;
  int? color;
  RxBool isSelected = false.obs;

  Selector({
    this.label,
    this.textIcon,
    this.subLabel,
    this.color,
    bool isSelected = false,
  }) {
    this.isSelected.value = isSelected;
  }

  Selector.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    subLabel = json['subLabel'];
    textIcon = json['textIcon'];
    color = json['color'];
    isSelected.value = json['isSelected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['subLabel'] = this.subLabel;
    data['textIcon'] = this.textIcon;
    data['color'] = this.color;
    data['isSelected'] = this.isSelected.value;
    return data;
  }
}
