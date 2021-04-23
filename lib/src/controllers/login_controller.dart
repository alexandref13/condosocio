import 'dart:convert';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:condosocio/src/services/listOfCondo/list_of_condo_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  ThemeController themeController = Get.put(ThemeController());

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var id = ''.obs;
  var idcond = ''.obs;
  var tipo = ''.obs;
  var imgperfil = ''.obs;
  var emailUsu = ''.obs;
  var nomeCondo = ''.obs;
  var imgcondo = ''.obs;
  var nome = ''.obs;
  var condoTheme = ''.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var listOfCondo = [].obs;

  Future hasMoreEmail(String emailS) async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('email', emailS);
    final response = await http.get(Uri.https('www.condosocio.com.br',
        '/flutter/unidadesLista.php', {"email": emailS}));
    var dados = json.decode(response.body);

    listOfCondo.value =
        dados.map((model) => ListOfCondo.fromJson(model)).toList();
    return dados;
  }

  login() async {
    final response = await http
        .post(Uri.https("condosocio.com.br", '/flutter/login.php'), body: {
      "login": email.value.text,
      "senha": password.value.text,
    });

    var dadosUsuario = json.decode(response.body);
    if (dadosUsuario['valida'] == 1) {
      return dadosUsuario;
    } else {
      return null;
    }
  }

  storageId() async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('id', id.value.toString());
  }

  newLogin(String newId) {
    http.post(Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
        body: {"id": newId}).then((response) {
      var dados = json.decode(response.body);
      id(dados['idusu']);
      idcond(dados['idcond']);
      emailUsu(dados['email']);
      tipo(dados['tipo']);
      imgperfil(dados['imgperfil']);
      nomeCondo(dados['nome_condo']);
      imgcondo(dados['imgcondo']);
      nome(dados['nome']);
      condoTheme(dados['cor']);

      themeController.setTheme(condoTheme.value);

      Get.toNamed('/home');
    });
  }
}
