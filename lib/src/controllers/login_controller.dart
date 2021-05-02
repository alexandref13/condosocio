import 'dart:convert';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:condosocio/src/services/listOfCondo/list_of_condo_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

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
  var unidade = ''.obs;
  var condoTheme = ''.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  var listOfCondo = [];

  Future<void> launched;

  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future hasMoreEmail(String emailS) async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('email', emailS);
    final response = await http.get(Uri.https('www.condosocio.com.br',
        '/flutter/unidadesLista.php', {"email": emailS}));
    var dados = json.decode(response.body);
    listOfCondo = dados.map((model) => ListOfCondo.fromJson(model)).toList();
    return dados;
  }

  login() async {
    isLoading(true);
    final response = await http
        .post(Uri.https("condosocio.com.br", '/flutter/login.php'), body: {
      "login": email.value.text,
      "senha": password.value.text,
    });
    isLoading(false);

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
    box.write('id', id.value);
  }

  searchEmail() async {
    await GetStorage.init();
    final box = GetStorage();
    email.value.text = box.read('email');
  }

  newLogin(String newId) {
    isLoading(true);
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

      storageId();

      themeController.setTheme(condoTheme.value);

      Get.toNamed('/home');

      isLoading(false);
    });
  }

  checkbox() {
    isChecked(!isChecked.value);
  }
}
