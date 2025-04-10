import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class ClockMainLogic extends GetxController {

  Timer? timer;
  var ymdStr = '-'.obs;
  var weekDayStr = '-'.obs;
  var hourStr = '-'.obs;
  var minuteStr = '-'.obs;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      ymdStr.value = DateFormat('MM/dd/yyyy').format(now);
      weekDayStr.value = DateFormat('EEEE').format(now);
      hourStr.value = DateFormat('HH').format(now);
      minuteStr.value = DateFormat('mm').format(now);
    });
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  void onInit() async {
    super.onInit();
    startTimer();
  }

}
