import 'package:condosocio/src/themes/themes.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  void setTheme(String condo) async {
    if (condo == 'magenta') {
      Get.changeTheme(magenta);
    } else if (condo == 'admin') {
      Get.changeTheme(admin);
    } else if (condo == 'turquoise') {
      Get.changeTheme(turquoise);
    } else if (condo == 'blue') {
      Get.changeTheme(blue);
    } else if (condo == 'grayscale') {
      Get.changeTheme(grayscale);
    } else if (condo == 'red') {
      Get.changeTheme(red);
    } else if (condo == 'orange') {
      Get.changeTheme(orange);
    }
  }
}
