import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEnquetes {
  static Future getEnquetes() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/enquetes_vis.php'),
      body: {
        'idcond': loginController.idcond.value,
      },
    );
  }
}
