import 'package:condosocio/src/controllers/senha_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiSenha {
  static Future senha() async {
    SenhaController senhaController = Get.put(SenhaController());
    return await http.post(
      Uri.https('condosocio.com.br', '/flutter/senha_redefinir.php'),
      body: {
        'email': senhaController.email.value.text,
      },
    );
  }
}
