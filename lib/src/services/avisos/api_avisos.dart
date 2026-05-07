import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAvisos {
  static Future getAvisos({
    int page = 1,
    int limit = 20,
    String search = '',
  }) async {
    LoginController loginController = Get.put(LoginController());
    return await http.get(
      Uri.https(
        "www.condosocio.com.br",
        "/flutter/avisos.php",
        {
          "idusu": loginController.id.value,
          "page": page.toString(),
          "limit": limit.toString(),
          "search": search,
        },
      ),
    );
  }
}
