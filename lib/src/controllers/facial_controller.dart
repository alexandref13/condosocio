import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';

class FacialController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;
  var imgfacial = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }
}
