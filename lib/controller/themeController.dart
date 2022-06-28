import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

var brightness = SchedulerBinding.instance.window.platformBrightness;

GetStorage getStorage = GetStorage();
var dark = getStorage.read('_theme');
bool isDark = dark ?? brightness == Brightness.dark;

class ThemeController extends GetxController {
  RxBool isDarkMode = isDark.obs;

  // RxBool isDarkMode = (brightness == Brightness.dark).obs;
  void setDarkMode(bool value) {
    isDarkMode.value = value;
    getStorage.write('_theme', isDarkMode.value);
    // update();
  }
}
