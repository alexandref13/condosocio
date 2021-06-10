import 'package:condosocio/src/controllers/enquetes/visualizar_enquetes_controller.dart';
import 'package:condosocio/src/controllers/enquetes/votar_enquete.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiEnquetes {
  static Future getEnquetes() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/enquetes_vis.php'),
      body: {
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future votacaoEnquete() async {
    LoginController loginController = Get.put(LoginController());
    VisualizarEnquetesController visualizarEnquetesController =
        Get.put(VisualizarEnquetesController());

    print({
      'id ${loginController.id.value}',
      'idenq ${visualizarEnquetesController.idenq.value}',
    });

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/enquetes_votacao.php'),
      body: {
        'idusu': loginController.id.value,
        'idenq': visualizarEnquetesController.idenq.value,
      },
    );
  }

  static Future<dynamic> votarEnquete() async {
    LoginController loginController = Get.put(LoginController());
    VisualizarEnquetesController visualizarEnquetesController =
        Get.put(VisualizarEnquetesController());
    VotarEnqueteController enquetesController =
        Get.put(VotarEnqueteController());

    print('valor enquete: ${enquetesController.i.value}');
    print('idenq: ${visualizarEnquetesController.idenq.value}');

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/enquete_votar.php'),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'idenq': visualizarEnquetesController.idenq.value,
        'resposta': enquetesController.i.value.toString(),
      },
    );
  }
}
