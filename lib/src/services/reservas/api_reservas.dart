import 'package:condosocio/src/controllers/login_controller.dart';
import 'package:condosocio/src/controllers/reservas/reservas_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiReservas {
  static Future getAreas() async {
    LoginController loginController = Get.put(LoginController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/areas_buscar.php"),
      body: {
        'idcond': loginController.idcond.value,
      },
    );
  }

  static Future agendaReservas() async {
    LoginController loginController = Get.put(LoginController());
    ReservasController reservasController = Get.put(ReservasController());

    return await http.post(
      Uri.https("www.condosocio.com.br", "/flutter/reservas_agenda.php"),
      body: {
        'idcond': loginController.idcond.value,
        'idusu': loginController.id.value,
        'nome_area': reservasController.nome.value,
      },
    );
  }
}
