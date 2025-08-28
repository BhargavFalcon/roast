import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
    const SystemUiOverlayStyle(
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
      theme: ThemeData(
        fontFamily: 'AptosNarrow', // 👈 Default font पूरे app में
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'AptosNarrow'),
          bodyMedium: TextStyle(fontFamily: 'AptosNarrow'),
          bodySmall: TextStyle(fontFamily: 'AptosNarrow'),
          titleLarge: TextStyle(
            fontFamily: 'AptosDisplay',
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontFamily: 'AptosSemiBold',
            fontWeight: FontWeight.w600,
          ),
          titleSmall: TextStyle(
            fontFamily: 'AptosExtraBold',
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    ),
  );
}
