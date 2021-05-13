import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAcessosSaida {
  static Future getAcessosSaida() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/acesso_saida_vis.php", {
        "idusu": loginController.id.value,
      }),
    );
  }
}
