import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthController extends GetxController {
  ThemeController themeController = Get.put(ThemeController());
  LoginController loginController = Get.put(LoginController());
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canCheckBiometrics;
  List<BiometricType> availableBiometrics;
  bool isAuthenticating = false;
  var rota = TextEditingController().obs;

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await autoLogIn();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> autoLogIn() async {
    await GetStorage.init();
    final box = GetStorage();
    var id = box.read('id');
    var email = box.read('email');
    var idcond = box.read('idcondController');
    if (id != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        /*biometricOnly: true,
        stickyAuth: true,
        useErrorDialogs: true,
        iOSAuthStrings: IOSAuthMessages(
          cancelButton: "Cancelar",
        ),

        androidAuthStrings: AndroidAuthMessages(
          biometricHint: "Para acesso rapido entre com sua biometria",
          signInTitle: "Entre com a biometria",
          cancelButton: "Cancelar",
        ),*/
      );

      if (isAuthenticated) {
        loginController.isLoading.value = true;
        http.post(Uri.https('www.alvocomtec.com.br', '/flutter/dados_usu.php'),
            body: {"id": id}).then((response) {
          loginController.hasMoreEmail(email).then((value) {
            print('idcond autentic: $idcond');
            if (value.length > 1 && idcond == '') {
              Get.toNamed('/listOfCondo');
              loginController.isLoading.value = false;
              loginController.haveListOfCondo.value = true;
            } else {
              if (value.length > 1) {
                loginController.haveListOfCondo.value = true;
              } else {
                loginController.haveListOfCondo.value = false;
              }
              var dados = json.decode(response.body);
              print('auth: $dados');

              loginController.id(dados['idusu']);
              loginController.idcond(dados['idcond']);
              loginController.emailUsu(dados['email']);
              loginController.tipo(dados['tipo']);
              loginController.imgperfil(dados['imgperfil']);
              loginController.nomeCondo(dados['nome_condo']);
              loginController.imgcondo(dados['imgcondo']);
              loginController.nome(dados['nome']);
              loginController.sobrenome(dados['sobrenome']);
              loginController.condoTheme(dados['cor']);
              loginController.genero(dados['genero']);
              loginController.birthdate(dados['aniversario']);
              loginController.phone(dados['cel']);
              loginController.logradouro(dados['logradouro']);
              loginController.tipoun(dados['tipoun']);
              loginController.idadm(dados['idadm']);
              loginController.dep(dados['dep']);
              loginController.condofacial(dados['condofacial']);
              loginController.ctlfacial(dados['ctlfacial']);
              loginController.imgfacial(dados['imgfacial']);

              loginController
                  .websiteAdministradora(dados['website_administradora']);
              loginController.licenca(dados['licenca']);

              themeController.setTheme(loginController.condoTheme.value);

              var sendTags = {
                'idusu': loginController.id.value,
                'nome': loginController.nome.value,
                'sobrenome': loginController.sobrenome.value,
                'idcond': loginController.idcond.value,
                'tipousuario': loginController.tipo.value,
                'genero': loginController.genero.value,
                'tipoun': loginController.tipoun.value,
                'logradouro': loginController.logradouro.value,
              };

              OneSignal.shared.sendTags(sendTags).then((response) {
                print("Successfully sent tags with response: $response");
              }).catchError((error) {
                print("Encountered an error sending tags: $error");
              });

              if (rota.value.text == "") {
                Get.toNamed('/home');
              } else {
                Get.toNamed(rota.value.text);
              }
              loginController.isLoading.value = false;
            }
          });
        });
      } else {
        loginController.isLoading.value = false;
        return;
      }
    }
  }

  @override
  void onInit() {
    localAuthentication.isDeviceSupported().then((isSupported) {
      if (isSupported) {
        authenticate();
      }
    });
    super.onInit();
  }
}
