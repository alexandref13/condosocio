import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthController extends GetxController {
  ThemeController themeController = Get.put(ThemeController());
  LoginController loginController = Get.put(LoginController());
  LocalAuthentication localAuthentication = LocalAuthentication();

  bool canCheckBiometrics;
  List<BiometricType> availableBiometrics;
  bool isAuthenticating = false;

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
    if (id != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        biometricOnly: true,
        stickyAuth: true,
        useErrorDialogs: true,
        iOSAuthStrings: IOSAuthMessages(
          cancelButton: "Cancelar",
        ),
        androidAuthStrings: AndroidAuthMessages(
          biometricHint: "Para acesso rapido entre com sua biometria",
          signInTitle: "Entre com a biometria",
          cancelButton: "Cancelar",
        ),
      );
      if (isAuthenticated) {
        loginController.isLoading.value = false;
        http.post(Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php'),
            body: {"id": id}).then((response) {
          var dados = json.decode(response.body);
          loginController.id(dados['idusu']);
          loginController.idcond(dados['idcond']);
          loginController.emailUsu(dados['email']);
          loginController.tipo(dados['tipo']);
          loginController.imgperfil(dados['imgperfil']);
          loginController.nomeCondo(dados['nome_condo']);
          loginController.imgcondo(dados['imgcondo']);
          loginController.nome(dados['nome']);

          Get.toNamed('/home');
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
      isSupported ? authenticate() : print('Nao suporta');
    });
    super.onInit();
  }
}
