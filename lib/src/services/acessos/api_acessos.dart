import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAcessos {
  static Future getAcessos() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/acessovis.php", {
        "idUsu": loginController.id.value,
      }),
    );
  }

  static Future sendAcesso() async {
    LoginController loginController = Get.put(LoginController());
    AcessosController acessosController = Get.put(AcessosController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/visitantes_inc.php'),
      body: {
        'id': loginController.id.value,
        'idcond': loginController.idcond.value,
        'tipopessoa': acessosController.itemSelecionado.value,
        'pessoa': acessosController.name.value.text,
        'cel': acessosController.phone.value.text,
      },
    );
  }

  static Future deleteAcesso() async {
    AcessosController acessosController = Get.put(AcessosController());
    return await http.get(
      Uri.https('www.condosocio.com.br', '/flutter/acesso_excluir.php',
          {'idace': acessosController.idAce.value}),
    );
  }
}
