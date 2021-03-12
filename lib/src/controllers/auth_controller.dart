import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final LoginController loginController = Get.put(LoginController());
  final LocalAuthentication localAuthentication = LocalAuthentication();

  bool canCheckBiometrics;
  List<BiometricType> availableBiometrics;
  bool isAuthenticating = false;

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await autoLogIn();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await localAuthentication.canCheckBiometrics;
    return isAvailable;
  }

  Future<void> _getListOfBiometricTypes() async {
    List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    print(availableBiometrics);
  }

  Future<void> autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String id = prefs.getString('id');

    if (id != null) {
      bool isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Autenticar para realizar Login na plataforma",
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (isAuthenticated) {
        loginController.isLoading.value = false;
        loginController.tipo.value = 'ADMIN';
        loginController.imgperfil.value = '';
        loginController.emailUsu.value = 'alefernandeseng@gmail.com';
        loginController.nomeCondo.value = "ALVO";
        loginController.imgcondo.value = '';
        loginController.nome.value = "Alexandre Fernandes";
        Get.toNamed('/home');
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
