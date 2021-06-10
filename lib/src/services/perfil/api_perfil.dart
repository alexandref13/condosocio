import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/perfil_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiPerfil {
  static Future editPerfil() async {
    LoginController loginController = Get.put(LoginController());
    PerfilController perfilController = Get.put(PerfilController());




    return await http.post(
        Uri.https("www.condosocio.com.br", "/flutter/perfil_alterar.php"),
        body: {
          'idusu': loginController.id.value,
          'nome': perfilController.name.value.text,
          'sobrenome': perfilController.secondName.value.text,
          'aniversario': perfilController.newDate.value,
          'celular': perfilController.phone.value.text,
          'genero': perfilController.itemSelecionado.value,
        });
    
  }
}
