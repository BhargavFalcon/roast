import 'package:get/get.dart';

import '../modules/choose_your_targets/bindings/choose_your_targets_binding.dart';
import '../modules/choose_your_targets/views/choose_your_targets_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/pick_your_poison/bindings/pick_your_poison_binding.dart';
import '../modules/pick_your_poison/views/pick_your_poison_view.dart';
import '../modules/stay_loop/bindings/stay_loop_binding.dart';
import '../modules/stay_loop/views/stay_loop_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PICK_YOUR_POISON;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
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
  ];
}
