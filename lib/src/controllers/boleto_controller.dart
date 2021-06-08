import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoletoController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;

  @override
  void onInit() {
    email.value.text = loginController.emailUsu.value;
    super.onInit();
  }
}
