import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiDependentes {
  static Future<dynamic> sendDependentes() async {
    LoginController loginController = Get.put(LoginController());
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/dependentes_inc.php"),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'nome': dependentesController.nome.value.text,
        'sobrenome': dependentesController.sobrenome.value.text,
        'email': dependentesController.email.value.text,
        'genero': dependentesController.itemSelecionado.value,
        'celular': dependentesController.celular.value.text,
        'tipo': dependentesController.tipoUsuario.value,
      },
    );
  }

  static Future getDependentes() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/flutter/dependentes_buscar.php'),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future changeStatus(String status) async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https(
          'www.condosocio.com.br',
          '/flutter/dependentes_status_mudar.php',
          {'idep': dependentesController.idep.value, 'status': status}),
    );
  }

  static Future deleteDependente() async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https('www.condosocio.com.br', '/flutter/dependente_excluir.php',
          {'idep': dependentesController.idep.value}),
    );
  }
}
