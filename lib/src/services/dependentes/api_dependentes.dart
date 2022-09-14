import 'package:condosocio/src/controllers/dependentes_controller.dart';
import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiDependentes {
  static Future<dynamic> sendDependentes() async {
    LoginController loginController = Get.put(LoginController());
    DependentesController dependentesController =
        Get.put(DependentesController());
    print(dependentesController.isChecked.value);
    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/dependentes_incluir.php"),
      body: {
        'idusu': loginController.id.value,
        'idcond': loginController.idcond.value,
        'nome': dependentesController.nome.value.text,
        'sobrenome': dependentesController.sobrenome.value.text,
        'email': dependentesController.email.value.text,
        'genero': dependentesController.itemSelecionado.value,
        'celular': dependentesController.celular.value.text,
        'tipo': dependentesController.tipoUsuario.value,
        'horaEnt': dependentesController.startDate.value,
        'horaSai': dependentesController.endDate.value,
        'acesso': dependentesController.isChecked.value.toString(),
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

  static Future reenviarEmail(String email) async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.post(
      Uri.https('www.condosocio.com.br', '/acond/enviarEmail.php'),
      body: {
        'idusu': dependentesController.idep.value,
        'email': email,
      },
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

  static Future delFace() async {
    DependentesController dependentesController =
        Get.put(DependentesController());

    return await http.get(
      Uri.https('www.condosocio.com.br', '/flutter/face_excluir.php',
          {'idep': dependentesController.idep.value}),
    );
  }

  static Future sendWhatsApp(String celular, String idep) async {
    return await http.get(
      Uri.https(
          'www.condosocio.com.br', '/flutter/prestador_whatsapp_chave.php', {
        'celular': celular,
        'idep': idep,
      }),
    );
  }
}
