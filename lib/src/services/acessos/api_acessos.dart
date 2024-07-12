import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../controllers/acessos/acessos_controller_espera.dart';

class ApiAcessos {
  static Future getAcessos() async {
    LoginController loginController = Get.put(LoginController());
    print("idUsu Acessovis: ${loginController.id.value}");
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

  static Future deleteAcesso(String espera) async {
    LoginController loginController = Get.put(LoginController());

    if (espera == "1") {
      AcessosController acessosController = Get.put(AcessosController());
      return await http.get(
        Uri.https('www.condosocio.com.br', '/flutter/acesso_excluir.php', {
          'idace': acessosController.idAce.value,
          'idcond': loginController.idcond.value,
          'idvis': acessosController.idvis.value,
        }),
      );
    } else {
      AcessosEsperaController acessosEsperaController =
          Get.put(AcessosEsperaController());
      return await http.get(
        Uri.https('www.condosocio.com.br', '/flutter/acesso_excluir.php', {
          'idace': acessosEsperaController.idAce.value,
          'idcond': loginController.idcond.value,
          'idvis': acessosEsperaController.idvis.value,
        }),
      );
    }
  }

  static Future getFav() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
        Uri.https('www.condosocio.com.br', '/flutter/favoritos_buscar.php'),
        body: {'idusu': loginController.id.value});
  }

  static Future getAFavorite() async {
    AcessosController acessosController = Get.put(AcessosController());
    return await http.get(
      Uri.https(
        'www.condosocio.com.br',
        '/flutter/favorito_escolhido.php',
        {"idfav": acessosController.firstId.value},
      ),
    );
  }

  static Future deleteFav() async {
    AcessosController acessosController = Get.put(AcessosController());

    return await http.get(Uri.https(
        'www.condosocio.com.br',
        '/flutter/favorito_excluir.php',
        {"idfav": acessosController.firstId.value}));
  }

  static Future addFav(bool fav) async {
    LoginController loginController = Get.put(LoginController());
    AcessosController acessosController = Get.put(AcessosController());

    print("FAV api_acessos: $fav");
    var favString = fav ? '1' : '0';

    print("FAVString: $favString");

    print(
        "${loginController.id.value.toString()} | $favString | ${acessosController.idAce.value.toString()}  | ${acessosController.name.value.text} |  ${acessosController.tel.value.toString()} ");

    return await http.get(
      Uri.https(
        "www.condosocio.com.br",
        "/flutter/favoritos_alternar.php",
        {
          "idusu": loginController.id.value.toString(),
          "idfav": favString, // Convertendo bool para string
          "idace": acessosController.idAce.value.toString(),
          "nome": acessosController.name.value.text,
          "tel": acessosController.tel.value.toString(),
        },
      ),
    );
  }

  static Future addFavConvite() async {
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
        "www.condosocio.com.br",
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
