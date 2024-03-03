import 'dart:convert';
import 'package:condosocio/src/controllers/convites/convites_controller.dart';
import 'package:condosocio/src/controllers/convites/visualizar_convites_controller.dart';
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
      Uri.https('www.condosocio.com.br', '/flutter/convites_info2.php'),
      body: {
        'idconv': id,
      },
    );
  }

  static Future getBannerTelaInicial() async {
    LoginController loginController = Get.put(LoginController());
    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/bannerTelaInicial.php'),
      body: {
        'idusu': loginController.id.value,
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

  static Future deleleAGuest() async {
    ConvitesController convitesController = Get.put(ConvitesController());
    LoginController loginController = Get.put(LoginController());
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());

    print('idConv: ${visualizarConvitesController.idConv.value}');
    return await http.post(
      Uri.https(
          'www.condosocio.com.br', '/flutter/convites_excluir_convidados.php'),
      body: {
        'idconv': visualizarConvitesController.idConv.value,
        'convidados': json.encode(convitesController.guestList),
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future sendAcesso(
      String startDate, String endDate, bool acesso) async {
    LoginController loginController = Get.put(LoginController());
    ConvitesController convitesController = Get.put(ConvitesController());
    print('idusu: ${loginController.id.value}');
    print('idcond: ${loginController.idcond.value}');
    print(
        'titulo: ${convitesController.inviteName.value.text == '' ? 'Convite de ${loginController.nome.value}' : convitesController.inviteName.value.text}');
    print('datainicial: $startDate');
    print('datafinal: $endDate');
    print('convidados: ${json.encode(convitesController.guestList)}');
    print('acesso: $acesso');

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
        'acesso': acesso.toString(),
      },
    );
  }

  static Future sendWhatsApp() async {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());
    print(
        'Celular Whatsapp: ${visualizarConvitesController.whatsappNumber.value.text}');
    print('Celular Raiz: ${visualizarConvitesController.tel.value}');
    print('idconv: ${visualizarConvitesController.idConv.value}');
    print('nome: ${visualizarConvitesController.nameGuest.value}');
    print('celraiz: ${visualizarConvitesController.tel.value}');
    print(
        'whatsapp: ${visualizarConvitesController.whatsappNumber.value.text}');

    return await http.get(
      Uri.https(
          'www.condosocio.com.br', '/flutter/convites_whatsapp_chave.php', {
        'idconv': visualizarConvitesController.idConv.value,
        'nome': visualizarConvitesController.nameGuest.value,
        'celraiz': visualizarConvitesController.tel.value,
        'whatsapp': visualizarConvitesController.whatsappNumber.value.text,
      }),
    );
  }

  static Future verificaWhatsApp() async {
    VisualizarConvitesController visualizarConvitesController =
        Get.put(VisualizarConvitesController());
    print('IDCONV VERIFICAR : ${visualizarConvitesController.idConv.value}');
    return await http.get(
      Uri.https(
          'www.condosocio.com.br', '/flutter/convites_whatsapp_verificar.php', {
        'celular': visualizarConvitesController.tel.value,
        'idconv': visualizarConvitesController.idConv.value,
      }),
    );
  }
}
