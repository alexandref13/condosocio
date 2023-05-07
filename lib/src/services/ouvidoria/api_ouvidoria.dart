import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ouvidoria/responda_controller.dart';
import 'package:condosocio/src/controllers/ouvidoria/ouvidoria_controller.dart';
import 'package:condosocio/src/controllers/ouvidoria/visualizar_ouvidoria_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiOuvidoria {
  static Future sendOuvidoria() async {
    LoginController loginController = Get.put(LoginController());
    OuvidoriaController ouvidoriaController = Get.put(OuvidoriaController());

    return await http.post(
      Uri.https("www.alvocomtec.com.br", "/flutter/ouvidoria_inc.php"),
      body: {
        "idusu": loginController.id.value,
        "idcond": loginController.idcond.value,
        "assunto": ouvidoriaController.itemSelecionado.value,
        "mensagem": ouvidoriaController.message.value.text
      },
    );
  }

  static Future getOuvidoria() async {
    LoginController loginController = Get.put(LoginController());
    return await http.get(
      Uri.https("www.alvocomtec.com.br", "/flutter/ouvidoria_vis.php",
          {"idusu": loginController.id.value}),
    );
  }

  static Future getRespondaOuvidoria() async {
    VisualizarOuvidoriaController visualizarOuvidoriaController =
        Get.put(VisualizarOuvidoriaController());

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/ouvidoria_resp_vis.php'),
      body: {
        'idouv': visualizarOuvidoriaController.id.value,
      },
    );
  }

  static Future sendRespondaOuvidoria() async {
    LoginController loginController = Get.put(LoginController());
    RespondaController respondaController = Get.put(RespondaController());
    VisualizarOuvidoriaController visualizarOuvidoriaController =
        Get.put(VisualizarOuvidoriaController());

    print({
      'id:${loginController.id.value}',
      'idcond:${loginController.idcond.value}',
      'texto:${respondaController.texto.value.text}',
      'idouv:${visualizarOuvidoriaController.id.value}'
    });

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/ouvidoria_resp_inc.php'),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'texto': respondaController.texto.value.text,
        'idouv': visualizarOuvidoriaController.id.value,
      },
    );
  }
}
// 29817
