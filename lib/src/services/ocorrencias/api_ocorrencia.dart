import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/ocorrencias_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiOcorrencias {
  static Future getOcorrencias() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(Uri.https("www.condosocio.com.br",
        "/flutter/ocovis.php", {"idUsu": loginController.id.value}));
  }

  static Future sendOcorrencia(String path) async {
    LoginController loginController = Get.put(LoginController());
    OcorrenciasController ocorrenciasController =
        Get.put(OcorrenciasController());

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
}
