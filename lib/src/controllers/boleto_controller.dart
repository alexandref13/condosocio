import 'dart:convert';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/services/boleto/api_boleto.dart';
import 'package:get/get.dart';

class BoletoController extends GetxController {
  LoginController loginController = Get.put(LoginController());

  var isLoading = false.obs;
  var boletos = [].obs;

  sendBoleto() async {
    isLoading(true);
    var response = await ApiBoleto.sendBoleto();
    var dados = json.decode(response.body);

    isLoading(false);

    if (dados['status'] == '202') {
      var session = dados['session'];
      boleto() async {
        isLoading(true);
        var response = await ApiBoleto.linkBoleto(session);

        var dados = json.decode(response.body);

        boletos.assignAll(dados['data']);

        isLoading(false);

        Get.toNamed('/visualizarBoletos');
      }

      boleto();
    } else {
      return 'vazio';
    }
  }
}
