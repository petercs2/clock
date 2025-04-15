import 'package:get/get.dart';

import 'clock_timer_logic.dart';

class ClockTimerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
