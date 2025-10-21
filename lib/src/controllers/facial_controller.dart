// lib/src/controllers/facial_controller.dart
import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FacialController extends GetxController {
  final loginController = Get.put(LoginController());

  final isLoading = false.obs;
  final imgfacial = ''.obs;

  Future<dynamic> ResetFace() async {
    isLoading(true);
    final response = await ApiReset.resetFace();
    final dados = json.decode(response.body);
    isLoading(false);
    return dados;
  }

  @override
  void onInit() {
    super.onInit();
  }
}

class ApiReset {
  static Future<http.Response> resetFace() {
    final loginController = Get.put(LoginController());
    return http.post(
      Uri.https("www.condosocio.com.br", "/flutter/resetFace.php"),
      body: {
        "idusu": loginController.id.value,
        "idcond": loginController.idcond.value,
      },
    );
  }
}
