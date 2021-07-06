import 'dart:convert';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:condosocio/src/services/listOfCondo/list_of_condo_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  ThemeController themeController = Get.put(ThemeController());

  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var id = ''.obs;
  var idcond = ''.obs;
  var newId = ''.obs;
  var tipo = ''.obs;
  var imgperfil = ''.obs;
  var emailUsu = ''.obs;
  var nomeCondo = ''.obs;
  var imgcondo = ''.obs;
  var nome = ''.obs;
  var sobrenome = ''.obs;
  var genero = ''.obs;
  var unidade = ''.obs;
  var condoTheme = ''.obs;
  var dep = ''.obs;
  var phone = ''.obs;
  var birthdate = ''.obs;
  var idadm = ''.obs;
  var websiteAdministradora = ''.obs;
  var licenca = ''.obs;
  var tipoun = ''.obs;
  var logradouro = ''.obs;
  var tipousu = ''.obs;
  var nomeusu = ''.obs;
  var sobrenomeusu = ''.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  var haveListOfCondo = false.obs;

  var listOfCondo = [];

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void onRefresh() async {
    await GetStorage.init();
    final box = GetStorage();
    var emailS = box.read('email');
    hasMoreEmail(emailS);
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    refreshController.loadComplete();
  }

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
    isLoading(true);
    await GetStorage.init();
    final box = GetStorage();
    box.write('email', emailS);
    final response = await http.get(Uri.https('www.condosocio.com.br',
        '/flutter/unidadesLista.php', {"email": emailS}));
    var dados = json.decode(response.body);
    listOfCondo = dados.map((model) => ListOfCondo.fromJson(model)).toList();
    isLoading(false);
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
    box.write('emailController', email.value.text);
  }

  searchEmail() async {
    await GetStorage.init();
    final box = GetStorage();
    if (box.hasData('email')) {
      email.value.text = box.read('email');
    }
  }

  newLogin(String newId) {
    isLoading(true);
    http.post(Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
        body: {"id": newId}).then((response) {
      var dados = json.decode(response.body);

      print(dados);

      id(dados['idusu']);
      idcond(dados['idcond']);
      emailUsu(dados['email']);
      tipo(dados['tipo']);
      imgperfil(dados['imgperfil']);
      nomeCondo(dados['nome_condo']);
      imgcondo(dados['imgcondo']);
      nome(dados['nome']);
      sobrenome(dados['sobrenome']);
      condoTheme(dados['cor']);
      dep(dados['dep']);
      genero(dados['genero']);
      birthdate(dados['aniversario']);
      phone(dados['cel']);
      idadm(dados['idadm']);
      websiteAdministradora(dados['website_administradora']);
      licenca(dados['licenca']);
      storageId();

      themeController.setTheme(condoTheme.value);

      Get.offNamed('/home');

      isLoading(false);
    });
  }

  checkbox() {
    isChecked(!isChecked.value);
  }

  @override
  void onInit() {
    searchEmail();
    super.onInit();
  }
}
