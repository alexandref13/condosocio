import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiOuvidoria {
  static Future sendOuvidoria() async {
    LoginController loginController = Get.put(LoginController());
    OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/ouvidoria_inc.php"),
      body: {
        "id": loginController.id.value,
        "idcond": loginController.idcond.value,
        "assunto": ouvidoriaController.itemSelecionado,
        "mensagem": ouvidoriaController.message.value.text
      },
    );
  }

  static Future getOuvidoria() async {
    LoginController loginController = Get.put(LoginController());
    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/ouvidoria_vis.php",
          {"id": loginController.id.value}),
    );
  }
}
// 29817
