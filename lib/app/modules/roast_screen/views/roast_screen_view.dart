import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/roast_screen_controller.dart';

class RoastScreenView extends GetView<RoastScreenController> {
  const RoastScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RoastScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RoastScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
