import 'dart:async';
import 'dart:convert';

import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class AuthController extends GetxController {
  ThemeController themeController = Get.put(ThemeController());
  LoginController loginController = Get.put(LoginController());
  LocalAuthentication localAuthentication = LocalAuthentication();

  late bool canCheckBiometrics;
  late List<BiometricType> availableBiometrics;
  bool isAuthenticating = false;
  var rota = TextEditingController().obs;

  // ====== público (mantido) ======
  authenticate() async {
    if (await _isBiometricAvailable()) {
      await autoLogIn();
    }
  }

  // ====== checagens de biometria ======
  Future<bool> _isBiometricAvailable() async {
    try {
      final supported = await localAuthentication.isDeviceSupported();
      final canCheck = await localAuthentication.canCheckBiometrics;
      availableBiometrics = await localAuthentication.getAvailableBiometrics();
      canCheckBiometrics =
          supported && canCheck && availableBiometrics.isNotEmpty;
      return canCheckBiometrics;
    } catch (_) {
      return false;
    }
  }

  Future<void> diagnosticoRede() async {
    try {
      debugPrint('--- DIAGNÓSTICO DNS ---');
      final addrs = await InternetAddress.lookup('api-v4.condosocio.com.br');
      for (final a in addrs) {
        debugPrint('resolveu: ${a.address} | tipo: ${a.type}');
      }

      // Tenta v6 e v4 explicitamente (apenas para log/diagnóstico)
      final v6 = await InternetAddress.lookup(
        'api-v4.condosocio.com.br',
        type: InternetAddressType.IPv6,
      ).catchError((_) => <InternetAddress>[]);
      final v4 = await InternetAddress.lookup(
        'api-v4.condosocio.com.br',
        type: InternetAddressType.IPv4,
      ).catchError((_) => <InternetAddress>[]);

      debugPrint('AAAA count: ${v6.length} | A count: ${v4.length}');

      // Se existir IPv6, tenta um ping TCP rápido na porta 443
      if (v6.isNotEmpty) {
        try {
          debugPrint('tentando v6: ${v6.first.address}:443');
          final s = await Socket.connect(v6.first, 443,
              timeout: const Duration(seconds: 3));
          debugPrint('v6 OK');
          s.destroy();
        } catch (e) {
          debugPrint('v6 FALHOU: $e');
        }
      }

      if (v4.isNotEmpty) {
        try {
          debugPrint('tentando v4: ${v4.first.address}:443');
          final s = await Socket.connect(v4.first, 443,
              timeout: const Duration(seconds: 3));
          debugPrint('v4 OK');
          s.destroy();
        } catch (e) {
          debugPrint('v4 FALHOU: $e');
        }
      }
    } catch (e) {
      debugPrint('diagnóstico erro: $e');
    }
  }

  // ====== helper de POST com retry e timeout ======
  Future<http.Response> _postWithRetry(
    Uri uri, {
    required Map<String, String> body,
    int maxAttempts = 3,
    Duration timeout = const Duration(seconds: 5),
  }) async {
    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        final resp = await http.post(uri, body: body).timeout(timeout);
        return resp;
      } on TimeoutException {
        if (attempt == maxAttempts) rethrow; // estourou todas as tentativas
        // tenta de novo
      }
    }
    // não chega aqui
    throw TimeoutException('Tentativas esgotadas');
  }

  // ====== login automático com biometria ======
  Future<void> autoLogIn() async {
    await GetStorage.init();
    final box = GetStorage();
    var id = box.read('id');
    var email = box.read('email');
    var idcond = box.read('idcondController');

    print("Dados do Auth Controller: $id | $email | $idcond");

    if (id == null) return;

    bool isAuthenticated = false;
    try {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: true,
        ),
      );
    } catch (e) {
      print('local_auth error: $e');
      isAuthenticated = false;
    }

    if (!isAuthenticated) {
      loginController.isLoading.value = false;
      return;
    }

    loginController.isLoading.value = true;
    diagnosticoRede();
    try {
      final uri = Uri.https('www.condosocio.com.br', '/flutter/dados_usu.php');

      final startTime = DateTime.now();
      // timeout de 5s com 1 retry automático
      final response = await _postWithRetry(
        uri,
        body: {"id": id},
        maxAttempts: 2, // 1ª + 1 retry
        timeout: const Duration(seconds: 5),
      );
      final endTime = DateTime.now();
      print(
          'Tempo de resposta da API: ${endTime.difference(startTime).inMilliseconds}ms');

      if (response.statusCode != 200) {
        print(
            'dados_usu.php status=${response.statusCode} body=${response.body}');
        return;
      }

      late final Map<String, dynamic> dados;
      try {
        dados = json.decode(response.body) as Map<String, dynamic>;
      } catch (e) {
        print('JSON inválido: ${response.body}');
        return;
      }

      print('auth: $dados');

      // mantém exatamente seus sets
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
      loginController.websiteAdministradora(dados['website_administradora']);
      loginController.licenca(dados['licenca']);

      themeController.setTheme(loginController.condoTheme.value);

      // mantém seu mapeamento
      var sendTags = {
        'idusu': loginController.id.value,
        'nome': loginController.nome.value,
        'sobrenome': loginController.idcond.value,
      };

      OneSignal.User.addTags(sendTags).then((_) {
        print("Successfully sent tags: $sendTags");
      }).catchError((error) {
        print("Auth Encountered an error sending tags: $error");
      });

      final value = await loginController.hasMoreEmail(email);
      print('idcond autentic: $idcond');

      if (value.length > 1 && idcond == '') {
        Get.toNamed('/listOfCondo');
        loginController.haveListOfCondo.value = true;
        return;
      } else {
        loginController.haveListOfCondo.value = value.length > 1;
      }

      if (rota.value.text == "" && dados['valida'] != 0) {
        Get.toNamed('/home');
      } else {
        Get.toNamed(rota.value.text);
      }
    } on TimeoutException {
      // estourou as duas tentativas (5s + 5s)
      Get.snackbar(
        'Erro de conexão',
        'Não foi possível conectar. Verifique sua internet e tente novamente.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Theme.of(Get.context!).colorScheme.error,
        colorText: Colors.white, // texto branco
        margin: const EdgeInsets.all(12), // opcional: dá um respiro nas bordas
        borderRadius: 8, // opcional: cantos arredondados
        icon:
            const Icon(Icons.wifi_off, color: Colors.white), // opcional: ícone
      );
    } catch (e) {
      print('autoLogIn error: $e');
    } finally {
      loginController.isLoading.value = false;
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
