import 'package:condosocio/src/controllers/acheAqui/ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/acheAqui/pesquisa_ache_aqui_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiAcheAqui {
  static Future getAcheAqui() async {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());

    return await http.post(
      Uri.https(
          'www.condosocio.com.br', 'flutter/acheaqui_pesq_atividades.php'),
      body: {
        'tema': acheAquiController.tema.value,
      },
    );
  }

  static Future getAcheAquiForm() async {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', 'flutter/acheaqui_pesq_forn.php'),
      body: {
        'idcond': loginController.idcond.value,
        'idativ': acheAquiController.id.value,
      },
    );
  }

  static Future getAcheAquidetalhes() async {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', 'flutter/acheaqui_desc_forn.php'),
      body: {
        'idusu': loginController.idcond.value,
        'idforn': acheAquiController.idForm.value,
      },
    );
  }

  static Future acheAquiPesquisa() async {
    PesquisaAcheAquiController pesquisaAcheAquiController =
        Get.put(PesquisaAcheAquiController());

    return await http.post(
      Uri.https('www.condosocio.com.br', 'flutter/pesquisar_Ache.php'),
      body: {
        'pesquisa': pesquisaAcheAquiController.pesquisa.value.text,
      },
    );
  }

  static Future getAcheAquiAvaliacao() async {
    AcheAquiController acheAquiController = Get.put(AcheAquiController());

    return await http.post(
      Uri.https('www.condosocio.com.br', 'flutter/acheaqui_avaliacao.php'),
      body: {
        'idforn': acheAquiController.idForm.value,
      },
    );
  }
}
