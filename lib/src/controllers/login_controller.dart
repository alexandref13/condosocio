import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth/local_auth.dart';

class LoginController extends GetxController {
  var email = TextEditingController().obs;
  var password = TextEditingController().obs;
  var id = ''.obs;
  var tipo = ''.obs;
  var imgperfil = ''.obs;
  var emailUsu = ''.obs;
  var nomeCondo = ''.obs;
  var imgcondo = ''.obs;
  var nome = ''.obs;
  var isLoading = false.obs;
  var isLoggedIn = false.obs;

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  // authenticate() async {
  //   if (await _isBiometricAvailable()) {
  //     await _getListOfBiometricTypes();
  //     await autoLogin();
  //   }
  // }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await _localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics =
        await _localAuthentication.getAvailableBiometrics();
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = prefs.getString('id');

    if (id != null) {
      bool isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (isAuthenticated) {
        isLoading(true);
      }
    }
  }

  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http
        .post(Uri.https("condosocio.com.br", '/flutter/login.php'), body: {
      "login": email.value.text,
      "senha": password.value.text,
    });

    var dadosUsuario = json.decode(response.body);
    if (dadosUsuario['valida'] == 1) {
      id(dadosUsuario['idusu']);
      tipo(dadosUsuario['tipo']);
      imgperfil(dadosUsuario['imgperfil']);
      emailUsu(dadosUsuario['email']);
      nomeCondo(dadosUsuario['nome_condo']);
      imgcondo(dadosUsuario['imgcondo']);
      nome(dadosUsuario['nome']);

      prefs.setString('id', id.value);
      String getId = prefs.getString('id');
      print({
        'getId: $getId',
        'id: $id',
      });

      Get.toNamed('/home');
    } else {
      print('nao validado');
    }
  }
}
