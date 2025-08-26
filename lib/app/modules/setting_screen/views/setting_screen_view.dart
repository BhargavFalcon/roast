import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roast/app/constants/sizeConstant.dart';

import '../controllers/setting_screen_controller.dart';

class SettingScreenView extends GetView<SettingScreenController> {
  const SettingScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 5),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Settings",
                style: TextStyle(
                  fontSize: MySize.getHeight(24),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: MySize.getHeight(10)),
            Expanded(child: Column(children: [])),
          ],
        ),
      ),
    );
  }
}
