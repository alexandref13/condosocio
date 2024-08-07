import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiTutoriais {
  static Future getVideosTutoriais() async {
    LoginController loginController = Get.put(LoginController());
    print(loginController.id.value);
    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/videostutoriais.php",
          {'idcond': loginController.idcond.value}),
    );
  }
}
