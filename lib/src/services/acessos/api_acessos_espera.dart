import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAcessosEspera {
  static Future getAcessosEspera() async {
    LoginController loginController = Get.put(LoginController());
    print("idUsu AcessovisEspera: ${loginController.id.value}");
    return await http.get(
      Uri.https("www.alvocomtec.com.br", "/flutter/acessoespera.php", {
        "idUsu": loginController.id.value,
      }),
    );
  }

  static Future sendAcessoEspera() async {
    LoginController loginController = Get.put(LoginController());
    AcessosController acessosController = Get.put(AcessosController());

    return await http.post(
      Uri.https('www.alvocomtec.com.br', '/flutter/visitantes_inc.php'),
      body: {
        'id': loginController.id.value,
        'idcond': loginController.idcond.value,
        'tipopessoa': acessosController.itemSelecionado.value,
        'pessoa': acessosController.name.value.text,
        'cel': acessosController.phone.value.text,
      },
    );
  }

  static Future deleteAcessoEspera() async {
    AcessosController acessosController = Get.put(AcessosController());
    LoginController loginController = Get.put(LoginController());
    print('idace: ${acessosController.idAce.value}');
    return await http.get(
      Uri.https('www.alvocomtec.com.br', '/flutter/acesso_excluir.php', {
        'idace': acessosController.idAce.value,
        'idcond': loginController.idcond.value,
        'idvis': acessosController.idvis.value,
      }),
    );
  }

  static Future getFavEspera() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
        Uri.https('www.alvocomtec.com.br', '/flutter/favoritos_buscar.php'),
        body: {'idusu': loginController.id.value});
  }

  static Future getAFavoriteEspera() async {
    AcessosController acessosController = Get.put(AcessosController());
    return await http.get(
      Uri.https(
        'www.alvocomtec.com.br',
        '/flutter/favorito_escolhido.php',
        {"idfav": acessosController.firstId.value},
      ),
    );
  }

  static Future deleteFavEspera() async {
    AcessosController acessosController = Get.put(AcessosController());

    return await http.get(Uri.https(
        'www.alvocomtec.com.br',
        '/flutter/favorito_excluir.php',
        {"idfav": acessosController.firstId.value}));
  }

  static Future addFavEspera() async {
    AcessosController acessosController = Get.put(AcessosController());
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https(
        "www.alvocomtec.com.br",
        "/flutter/favoritos_alternar.php",
        {
          "idusu": loginController.id.value,
          "idfav": acessosController.idfav.value,
          "idace": acessosController.idAce.value,
          "nome": acessosController.name.value.text,
          "tel": acessosController.tel.value,
        },
      ),
    );
  }

  static Future addFavConviteEspera() async {
    AcessosController acessosController = Get.put(AcessosController());
    LoginController loginController = Get.put(LoginController());
    VisualizarConvitesController visualizarConviteController =
        Get.put(VisualizarConvitesController());

    print({
      "idfav": acessosController.idfav.value,
      "idusu": loginController.id.value,
      "nome": acessosController.name.value.text,
      "tel": acessosController.tel.value,
      "idconv": visualizarConviteController.idConv.value,
    });

    return await http.get(
      Uri.https(
        "www.alvocomtec.com.br",
        "/flutter/favoritos_alternar_convite.php",
        {
          "idusu": loginController.id.value,
          "nome": acessosController.name.value.text,
          "tel": acessosController.tel.value,
          "idconv": visualizarConviteController.idConv.value,
          "idfav": acessosController.idfav.value,
        },
      ),
    );
  }
}
