import 'package:condosocio/src/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  ThemeData theme = admin;

  void setTheme(String condo) async {
    print(condo);
    if (condo == 'admin') {
      Get.changeTheme(admin);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'magenta') {
      Get.changeTheme(magenta);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'turquoise') {
      Get.changeTheme(turquoise);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'blue') {
      Get.changeTheme(blue);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'grayscale') {
      Get.changeTheme(grayscale);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'red') {
      Get.changeTheme(red);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    } else if (condo == 'orange') {
      Get.changeTheme(orange);
      Get.changeThemeMode(
        ThemeMode.light,
      );
    }
  }
}
