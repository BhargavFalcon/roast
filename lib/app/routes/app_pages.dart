import 'package:get/get.dart';

import '../../main.dart';
import '../constants/api_constants.dart';
import '../constants/sizeConstant.dart';
import '../modules/choose_your_targets/bindings/choose_your_targets_binding.dart';
import '../modules/choose_your_targets/views/choose_your_targets_view.dart';
import '../modules/history_screen/bindings/history_screen_binding.dart';
import '../modules/history_screen/views/history_screen_view.dart';
import '../modules/main_home/bindings/main_home_binding.dart';
import '../modules/main_home/views/main_home_view.dart';
import '../modules/pick_your_poison/bindings/pick_your_poison_binding.dart';
import '../modules/pick_your_poison/views/pick_your_poison_view.dart';
import '../modules/roast_preview_screen/bindings/roast_preview_screen_binding.dart';
import '../modules/roast_preview_screen/views/roast_preview_screen_view.dart';
import '../modules/roast_screen/bindings/roast_screen_binding.dart';
import '../modules/roast_screen/views/roast_screen_view.dart';
import '../modules/setting_screen/bindings/setting_screen_binding.dart';
import '../modules/setting_screen/views/setting_screen_view.dart';
import '../modules/stay_loop/bindings/stay_loop_binding.dart';
import '../modules/stay_loop/views/stay_loop_view.dart';
import '../modules/web_view_screen/bindings/web_view_screen_binding.dart';
import '../modules/web_view_screen/views/web_view_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static String INITIAL = (isNullEmptyOrFalse(box.read(ArgumentConstant.start)))
      ? Routes.PICK_YOUR_POISON
      : Routes.MAIN_HOME;

  static final routes = [
    GetPage(
      name: _Paths.PICK_YOUR_POISON,
      page: () => const PickYourPoisonView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: PickYourPoisonBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_YOUR_TARGETS,
      page: () => const ChooseYourTargetsView(),
      binding: ChooseYourTargetsBinding(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
    ),
    GetPage(
      name: _Paths.STAY_LOOP,
      page: () => const StayLoopView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: StayLoopBinding(),
    ),
    GetPage(
      name: _Paths.MAIN_HOME,
      page: () => const MainHomeView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: MainHomeBinding(),
    ),
    GetPage(
      name: _Paths.ROAST_SCREEN,
      page: () => const RoastScreenView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: RoastScreenBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY_SCREEN,
      page: () => const HistoryScreenView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: HistoryScreenBinding(),
    ),
    GetPage(
      name: _Paths.SETTING_SCREEN,
      page: () => const SettingScreenView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: SettingScreenBinding(),
    ),
    GetPage(
      name: _Paths.ROAST_PREVIEW_SCREEN,
      page: () => const RoastPreviewScreenView(),
      transition: Transition.noTransition,
      transitionDuration: Duration.zero,
      binding: RoastPreviewScreenBinding(),
    ),
    GetPage(
      name: _Paths.WEB_VIEW_SCREEN,
      page: () => const WebViewScreenView(),
      binding: WebViewScreenBinding(),
    ),
  ];
}
