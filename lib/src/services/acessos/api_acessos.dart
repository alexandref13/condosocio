import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/acessos/visualizar_acessos_controller.dart';
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

  static Future getFav() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
        Uri.https('www.condosocio.com.br', '/flutter/favoritos_buscar.php'),
        body: {'idusu': loginController.id.value});
  }

  static Future getAFavorite() async {
    AcessosController acessosController = Get.put(AcessosController());
    return await http.get(Uri.https(
        'www.condosocio.com.br',
        '/flutter/favorito_escolhido.php',
        {"idfav": acessosController.firstId.value}));
  }

  static Future deleteFav() async {
    AcessosController acessosController = Get.put(AcessosController());

    return await http.get(Uri.https(
        'www.condosocio.com.br',
        '/flutter/favorito_excluir.php',
        {"idfav": acessosController.firstId.value}));
  }

  static Future addFav() async {
    VisualizarAcessosController visualizarAcessosController =
        Get.put(VisualizarAcessosController());
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https(
        "www.condosocio.com.br",
        "/flutter/favoritos_alternar.php",
        {
          "idusu": loginController.id.value,
          "idfav": visualizarAcessosController.idfav.value,
          "idace ": visualizarAcessosController.idace.value,
          "fav": visualizarAcessosController.fav.value,
        },
      ),
    );
  }
}
