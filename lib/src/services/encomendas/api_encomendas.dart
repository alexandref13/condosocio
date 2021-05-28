import 'package:condosocio/src/controllers/encomendas_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEncomendas {
  static Future getEncomendas() async {
    LoginController loginController = Get.put(LoginController());

    print(loginController.id.value);

    return await http.post(
      Uri.https('www.condosocio.com.br', 'flutter/encomendas_vis.php'),
      body: {
        'idusu': loginController.id.value,
      },
    );
  }

  static Future sendEncomendas() async {
    EncomendasController encomendasController = Get.put(EncomendasController());

    return await http.get(
      Uri.https(
        'www.condosocio.com.br',
        'flutter/encomendas_qrcode_recept.php',
        {
          'idenc': encomendasController.id.value,
        },
      ),
    );
  }
}
