import 'package:condosocio/src/controllers/acessos/saida/visualizar_acessos_saida_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAcessosSaida {
  static Future getAcessosSaida() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/acesso_saida_vis.php", {
        "idusu": loginController.id.value,
      }),
    );
  }

  static Future sendAcessosSaida(String path) async {
    LoginController loginController = Get.put(LoginController());
    VisualizarAcessosSaidaController saidaController =
        Get.put(VisualizarAcessosSaidaController());

    var uri =
        Uri.parse("https://www.condosocio.com.br/flutter/acesso_saida_inc.php");

    var request = http.MultipartRequest('POST', uri);

    request.fields['idusu'] = loginController.id.value;
    request.fields['idcond'] = loginController.idcond.value;
    request.fields['tiposai'] = saidaController.itemSelecionado.value;
    request.fields['nome'] = saidaController.nameController.value.text;
    request.fields['obs'] = saidaController.obs.value.text;

    if (path != '') {
      var pic = await http.MultipartFile.fromPath("image", path);

      request.files.add(pic);

      var response = await request.send();

      if (response.statusCode == 200) {
        return '1';
      } else
        return '0';
    } else {
      var response = await request.send();

      if (response.statusCode == 200) {
        return '1';
      } else
        return '0';
    }
  }
}
