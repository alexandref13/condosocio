import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiDocumentos {
  static Future getDocumentosAtas() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "${loginController.id.value}", "pasta": "1"}),
    );
  }

  static Future getDocumentosContratos() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "${loginController.id.value}", "pasta": "6"}),
    );
  }

  static Future getDocumentosConvencao() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(
      Uri.https("www.condosocio.com.br", "/flutter/documentos.php",
          {"idUsu": "${loginController.id.value}", "pasta": "2"}),
    );
  }

  static Future getDocumentosPrestacao() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(Uri.https(
        "www.condosocio.com.br",
        "/flutter/documentos.php",
        {"idUsu": "${loginController.id.value}", "pasta": "4"}));
  }

  static Future getDocumentosRegulamento() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(Uri.https(
        "www.condosocio.com.br",
        "/flutter/documentos.php",
        {"idUsu": "${loginController.id.value}", "pasta": "5"}));
  }

  static Future getDocumentosEdital() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(Uri.https(
        "www.condosocio.com.br",
        "/flutter/documentos.php",
        {"idUsu": "${loginController.id.value}", "pasta": "3"}));
  }

  static Future getDocumentosOutros() async {
    LoginController loginController = Get.put(LoginController());

    return await http.get(Uri.https(
        "www.condosocio.com.br",
        "/flutter/documentos.php",
        {"idUsu": "${loginController.id.value}", "pasta": "7"}));
  }
}
