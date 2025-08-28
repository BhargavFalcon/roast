import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:roast/app/constants/api_constants.dart';

import 'app/constants/daily_Notifications.dart';
import 'app/routes/app_pages.dart';

final box = GetStorage();
String apiKey =
    (Platform.isIOS)
        ? "appl_vxmyevdyyuSogbLLpujFDWUOFnu"
        : "goog_xFiJLWILtxmdNHbZntVaZNKGexJ";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await GetStorage.init();
  box.writeIfNull(ArgumentConstant.roastCoin, 3);
  await NotificationService.instance.init();
  await NotificationService.instance.scheduleDailyNotifications();
  await Purchases.setLogLevel(LogLevel.debug);
  await Purchases.configure(PurchasesConfiguration(apiKey));
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GoogleFonts.rubik().fontFamily),
    ),
  );
}
