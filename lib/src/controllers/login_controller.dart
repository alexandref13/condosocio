import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
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
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  Future<String> login() async {
    await GetStorage.init();
    final response = await http
        .post(Uri.https("condosocio.com.br", '/flutter/login.php'), body: {
      "login": email.value.text,
      "senha": password.value.text,
    });

    var dadosUsuario = json.decode(response.body);
    print(dadosUsuario);
    if (dadosUsuario['valida'] == 1) {
      id(dadosUsuario['idusu']);
      idcond(dadosUsuario['idcond']);
      tipo(dadosUsuario['tipo']);
      imgperfil(dadosUsuario['imgperfil']);
      emailUsu(dadosUsuario['email']);
      nomeCondo(dadosUsuario['nome_condo']);
      imgcondo(dadosUsuario['imgcondo']);
      nome(dadosUsuario['nome']);

      final box = GetStorage();
      box.write('id', id.value.toString());

      return id.value;
    } else {
      return null;
    }
  }
}
