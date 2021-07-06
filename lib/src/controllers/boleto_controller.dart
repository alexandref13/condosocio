import 'dart:convert';

import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/boleto/api_boleto.dart';
import 'package:get/get.dart';

class BoletoController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;

  sendBoleto() async {
    isLoading(true);
    var response = await ApiBoleto.sendBoleto();

    print(response);

    isLoading(false);
  }
}
