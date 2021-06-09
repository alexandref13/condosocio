import 'package:condosocio/src/controllers/email_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEmail {
  static Future email() async {
    EmailController emailController = Get.put(EmailController());
    return await http.post(
      Uri.https('condosocio.com.br', '/flutter/email_redefinir.php'),
      body: {
        'email': emailController.emailesqueci.value.text,
      },
    );
  }
}
