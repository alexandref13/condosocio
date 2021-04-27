import 'dart:convert';

import 'package:condosocio/src/controllers/acessos/acessos_controller.dart';
import 'package:condosocio/src/controllers/convites_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/convites/mapa_convites.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiConvites {
  static Future sendAcesso(String startDate, String endDate) async {
    LoginController loginController = Get.put(LoginController());
    ConvitesController convitesController = Get.put(ConvitesController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/convites_inc.php'),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'titulo': convitesController.inviteName.value.text,
        'datainicial': startDate,
        'datafinal': endDate,
        'convidados': json.encode(convitesController.guestList),
      },
    );
  }
}
