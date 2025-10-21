import 'dart:convert';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:condosocio/src/services/listOfCondo/list_of_condo_map.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
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
  var imgfacial = ''.obs;
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
  var condofacial = ''.obs;
  var ctlfacial = ''.obs;
  var licenca = ''.obs;
  var tipoun = ''.obs;
  var logradouro = ''.obs;
  var tipousu = ''.obs;
  var nomeusu = ''.obs;
  var sobrenomeusu = ''.obs;
  var isLoading = false.obs;
  var isChecked = false.obs;
  var haveListOfCondo = false.obs;
  var selectedIndex = 0.obs;

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

  late Future<void> launched;

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
    print('Email login: $emailS');
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

    // Registra o tempo inicial
    DateTime startTime = DateTime.now();

    try {
      print("🔑 Iniciando login com email: ${email.value.text}");

      final response = await http.post(
        Uri.https("www.condosocio.com.br", '/flutter/login.php'),
        body: {
          "login": email.value.text,
          "senha": password.value.text,
        },
      );

      // Calcula o tempo de resposta
      DateTime endTime = DateTime.now();
      Duration responseTime = endTime.difference(startTime);
      print(
          '⏱ Tempo de resposta da API login: ${responseTime.inMilliseconds}ms');

      print("📡 Status code: ${response.statusCode}");
      print("📥 Body: ${response.body}");

      var dadosUsuario = json.decode(response.body);

      if (dadosUsuario['valida'] == 1) {
        print("✅ Login válido para usuário: ${dadosUsuario['nome']}");
        isLoading(false);
        return dadosUsuario;
      } else {
        print("⚠️ Login inválido: ${dadosUsuario['msg'] ?? 'sem mensagem'}");
        return null;
      }
    } catch (e) {
      print("❌ Erro no login: $e");
      return null;
    } finally {
      isLoading(false);
    }
  }

  storageId() async {
    await GetStorage.init();
    final box = GetStorage();
    box.write('id', id.value);
    box.write('emailController', email.value.text);
    box.write('idcondController', idcond.value);
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
    print("🔑 Iniciando newLogin com id: $newId");

    http.post(
      Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
      body: {"id": newId},
    ).then((response) {
      print("📡 Status code (newLogin): ${response.statusCode}");
      print("📥 Body (newLogin): ${response.body}");

      var dados = json.decode(response.body);

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
      logradouro(dados['logradouro']);
      tipoun(dados['tipoun']);
      idadm(dados['idadm']);
      websiteAdministradora(dados['website_administradora']);
      licenca(dados['licenca']);
      condofacial(dados['condofacial']);
      ctlfacial(dados['ctlfacial']);
      imgfacial(dados['imgfacial']);

      print("✅ Usuário carregado: ${nome.value} ${sobrenome.value}");

      var sendTags = {
        'idusu': id.value,
        'nome': nome.value,
        'sobrenome': idcond.value,
      };

      OneSignal.User.addTags(sendTags).then((_) {
        print("📤 Successfully sent tags: $sendTags");
      }).catchError((error) {
        print("❌ Erro ao enviar tags para OneSignal: $error");
      });

      storageId();
      themeController.setTheme(condoTheme.value);

      print("➡️ Redirecionando para /home");
      Get.offNamed('/home');

      isLoading(false);
    }).catchError((error) {
      print("❌ Erro no newLogin: $error");
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
