import 'dart:convert';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiConvites {
  static Future getConvites() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/convites_buscar.php'),
      body: {
        'idusu': loginController.id.value,
      },
    );
  }

  static Future getAConvites(String id) async {
    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/convites_info.php'),
      body: {
        'idconv': id,
      },
    );
  }

  static Future deleleAConvite(String id) async {
    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/convites_excluir.php'),
      body: {
        'idconv': id,
      },
    );
  }

  static Future sendAcesso(String startDate, String endDate) async {
    LoginController loginController = Get.put(LoginController());
    ConvitesController convitesController = Get.put(ConvitesController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/convites_inc.php'),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'titulo': convitesController.inviteName.value.text == ''
            ? 'Convite de ${loginController.nome.value}'
            : convitesController.inviteName.value.text,
        'datainicial': startDate,
        'datafinal': endDate,
        'convidados': json.encode(convitesController.guestList),
      },
    );
  }
}
