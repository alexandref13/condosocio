import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FacialController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;
  var imgfacial = ''.obs;

  ResetFace() async {
    isLoading(true);

    final response = await ApiReset.resetFace();

    var dados = json.decode(response.body);

    isLoading(false);

    return dados;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class ApiReset {
  static Future resetFace() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/resetFace.php"),
      body: {
        "idusu": loginController.id.value,
        "idcond": loginController.idcond.value,
      },
    );
  }
}
