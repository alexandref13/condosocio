import 'package:condosocio/src/themes/themes.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  void setTheme(String condo) async {
    if (condo == 'cristal') {
      Get.changeTheme(cristalVille);
    } else if (condo == 'admin') {
      Get.changeTheme(admin);
    }
  }
}
