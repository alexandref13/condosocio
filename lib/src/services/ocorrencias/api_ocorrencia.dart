import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/ocorrencias_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/resposta_ocorrencias_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias/visualizar_ocorrencias_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiOcorrencias {
  static Future getOcorrencias() async {
    LoginController loginController = Get.put(LoginController());

    print(loginController.id.value);

    return await http.get(
      Uri.https(
        "www.condosocio.com.br",
        "/flutter/ocovis.php",
        {"idUsu": loginController.id.value},
      ),
    );
  }

  static Future sendOcorrencia(String path) async {
    LoginController loginController = Get.put(LoginController());
    OcorrenciasController ocorrenciasController =
        Get.put(OcorrenciasController());

    var date = ocorrenciasController.date.value.text.split('/');
    ocorrenciasController.date.value.text = '${date[2]}-${date[1]}-${date[0]}';

    print(ocorrenciasController.date.value.text);
    print(ocorrenciasController.hour.value.text);
    var uri =
        Uri.parse("https://www.condosocio.com.br/flutter/ocorrencias_inc.php");

    var request = http.MultipartRequest('POST', uri);

    request.fields['idusu'] = loginController.id.value;
    request.fields['idcond'] = loginController.idcond.value;
    request.fields['tituloco'] = ocorrenciasController.title.value.text;
    request.fields['descricaoco'] =
        ocorrenciasController.description.value.text;
    request.fields['dataoco'] = ocorrenciasController.date.value.text;
    request.fields['horaoco'] = ocorrenciasController.hour.value.text;
    request.fields['tipo'] = ocorrenciasController.itemSelecionado.value;

    if (path != '') {
      var pic = await http.MultipartFile.fromPath("image", path);

      request.files.add(pic);
      var response = await request.send();

      if (response.statusCode == 200) {
        return '1';
      } else
        return '0';
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      return '1';
    } else
      return '0';
  }

  static Future getOcorrenciasResp() async {
    VisualizarOcorrenciasController visualizarOcorrenciasController =
        Get.put(VisualizarOcorrenciasController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "flutter/ocorrencias_resp_vis.php"),
      body: {
        'idoco': visualizarOcorrenciasController.idoco.value,
      },
    );
  }

  static Future sendOcorrenciasResp() async {
    LoginController loginController = Get.put(LoginController());
    VisualizarOcorrenciasController visualizarOcorrenciasController =
        Get.put(VisualizarOcorrenciasController());
    RespostaOcorrenciasController respostaOcorrenciasController =
        Get.put(RespostaOcorrenciasController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "flutter/ocorrencias_resp_inc.php"),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'idoco': visualizarOcorrenciasController.idoco.value,
        'texto': respostaOcorrenciasController.texto.value.text,
      },
    );
  }
}
