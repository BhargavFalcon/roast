import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:http/http.dart' as http;
import 'package:roast/app/constants/api_constants.dart';
import 'package:roast/app/constants/color_constant.dart';

import '../../main.dart';

class FeedbackManager {
  static TextEditingController feedbackController = TextEditingController();

  static Future<void> incrementButtonClick(BuildContext context) async {
    final clickCount = box.read(ArgumentConstant.buttonClickCountKey) ?? 0;
    final newClickCount = clickCount + 1;
    box.write(ArgumentConstant.buttonClickCountKey, newClickCount);
    if (newClickCount >= 5) {
      _showFeedbackPrompt(context);
      box.write(ArgumentConstant.buttonClickCountKey, 0);
    }
  }

  static Future<void> _showFeedbackPrompt(BuildContext context) async {
    final result = await showCupertinoDialog<String>(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text('Are you enjoying Roasting people?'),
            actions: [
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, 'NO'),
                child: Text('No', style: TextStyle(color: Colors.red)),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, 'YES'),
                child: Text('Yes', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );

    if (result == 'YES') {
      await _requestAppReview();
    } else if (result == 'NO') {
      await _showFeedbackForm(context);
    }
  }

  static Future<void> _requestAppReview() async {
    final review = InAppReview.instance;
    if (await review.isAvailable()) {
      await review.requestReview();
    }
  }

  static Future<void> _showFeedbackForm(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => CupertinoAlertDialog(
            title: Text(
              'Help us improve',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            content: Column(
              children: [
                SizedBox(height: 16),
                CupertinoTextField(
                  controller: feedbackController,
                  placeholder: 'Share your feedback...',
                  textAlign: TextAlign.start,
                  placeholderStyle: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  if (feedbackController.value.text.isNotEmpty) {
                    sendFeedBack(
                      subject:
                          "Baby Bloom ${Platform.isIOS ? 'iOS' : 'Android'}",
                      content: feedbackController.value.text,
                    );
                    Navigator.pop(context);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
    );
  }

  static Future<void> resetButtonClickCount() async {
    box.write(ArgumentConstant.buttonClickCountKey, 0);
  }

  static Future<int> getButtonClickCount() async {
    return box.read(ArgumentConstant.buttonClickCountKey) ?? 0;
  }
}

Future<void> sendFeedBack({
  required String subject,
  required String content,
}) async {
  final response = await http.post(
    Uri.parse("https://falconsolutions.co/babybloom/sendMail.php"),
    body: {"subject": subject, "content": content},
  );

  if (response.statusCode == 200) {
    Fluttertoast.showToast(
      msg: "Feedback sent successfully!",
      textColor: Colors.white,
      backgroundColor: ColorConstants.primaryColor,
    );
  } else {
    print("Error: ${response.body}");
  }
}
