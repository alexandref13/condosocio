import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/senha_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiSenha {
  static Future senha() async {
    LoginController loginController = Get.put(LoginController());
    SenhaController senhaController = Get.put(SenhaController());
    return await http.post(
      Uri.https('alvocomtec.com.br', '/flutter/senha_alterar.php'),
      body: {
        'idusu': loginController.id.value,
        'senha': senhaController.senhanova.value.text,
      },
    );
  }
}
