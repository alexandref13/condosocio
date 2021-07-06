import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiBoleto {
  static Future sendBoleto() async {
    LoginController loginController = Get.put(LoginController());
    var response = await http.post(
      Uri.https('www.condosocio.com.br', 'boletos_auth_super.php'),
      body: {
        'email': loginController.email.value.text,
        'senha': loginController.password.value.text,
        'licensa': 'servcon',
      },
    );

    return response.statusCode;
  }
}
